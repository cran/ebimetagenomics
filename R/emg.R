## ebimetagenomics package code

require(sads)

getProjectsList<-function() {
    url="https://www.ebi.ac.uk/metagenomics/projects/doExportDetails?search=Search&studyVisibility=ALL_PUBLISHED_PROJECTS"
    pl=read.csv(url,stringsAsFactors=FALSE)
    rownames(pl)=pl$Study.ID
    pl
}

read.project.csv<-function(fileName,projectID,...) {
    summ=read.csv(fileName,stringsAsFactors=FALSE,...)
    rownames(summ)=summ$Run.ID
    attr(summ,"project.id")=projectID
    summ
}

getProjectSummary<-function(projectID) {
    url=paste("https://www.ebi.ac.uk/metagenomics/projects",projectID,"overview/doExport",sep="/")
    summ=read.project.csv(url,projectID)
    summ
}

projectSamples<-function(summ) {
    unique(sort(summ$Sample.ID))
}

projectRuns<-function(summ) {
    summ$Run.ID
}

runsBySample<-function(summ,sampleID) {
    summ$Run.ID[summ$Sample.ID==sampleID]
}

otu.url<-function(summ,runID) {
    runData=summ[runID,]
    projectID=attr(summ,"project.id")
    url=paste("https://www.ebi.ac.uk/metagenomics//projects",projectID,"samples",runData["Sample.ID"],"runs",runID,"results/versions",sprintf("%.1f",runData["Release.version"]),"taxonomy/OTU-TSV",sep="/")
    url
}

read.otu.tsv<-function(fileName,...) {
    otu = read.delim(fileName,header=FALSE,skip=2,colClasses=c("character","numeric","character"),stringsAsFactors=FALSE,...)
    names(otu) = c("OTU","Count","Tax")
    rownames(otu) = otu$OTU
    otu[order(-otu$Count),]
}

getRunOtu<-function(summ,runID,verb=FALSE,plot.preston=FALSE) {
    url=otu.url(summ,runID)
    if (verb)
        message(runID)
    otu=read.otu.tsv(url)
    if (plot.preston)
        selectMethod("plot","octav")(octav(otu$Count),main=paste("Preston plot for",runID))
    otu
}

mergeOtu<-function(...) {
  stack=rbind(...)
  comb=tapply(stack$Count,stack$OTU,sum)
  otu=data.frame(OTU=as.vector(rownames(comb)),Count=as.vector(comb),Tax=stack[rownames(comb),3])
  rownames(otu)=rownames(comb)
  otu[order(-otu$Count),]
}

getSampleOtu<-function(summ,sampleID,verb=TRUE,plot.preston=FALSE) {
    runs=runsBySample(summ,sampleID)
    runData=list()
    for (run in runs) {
        if (verb)
            message(paste(run,", ",sep=""),appendLF=FALSE)
        otu=getRunOtu(summ,run,plot.preston=plot.preston)
        runData[[run]]=otu
    }
    if (verb)
        message("END.")
    Reduce(mergeOtu,runData)
}

convertOtuTad <- function(otu) {
  sad = as.data.frame(table(otu$Count))
  names(sad) = c("abund","Freq")
  sad$abund = as.numeric(as.character(sad$abund))
  sad
}

plotOtu <- function(otu) {
  comm=otu$Count
  op=par(mfrow=c(2,2))
  barplot(comm,xlab="Species",ylab="Abundance",main="Taxa abundance")
  tad = convertOtuTad(otu)
  barplot(tad[,2],names.arg=tad[,1],xlab="Abundance",
                                ylab="# species",main="TAD")
  selectMethod("plot","octav")(octav(comm),main="Preston plot")
  plot(rad(comm),main="Rank abundance")
  par(op)
}




## eof


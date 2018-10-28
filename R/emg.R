## ebimetagenomics package code

require(sads)
require(vegan)
require(breakaway)

baseURL = "https://www.ebi.ac.uk/metagenomics/api/v1"

getProjectsList<-function() {
    url=paste(baseURL,"studies?format=csv",sep="/")
    pl=read.csv(url,stringsAsFactors=FALSE)
    rownames(pl)=pl$accession
    pl
}

read.project.csv<-function(fileName,projectID,...) {
    summ=read.csv(fileName,stringsAsFactors=FALSE,...)
    runID = sapply(sapply(summ$run,function(s){strsplit(s,'?',fixed=TRUE)[[1]][1]}),function(s){strsplit(s,'/',fixed=TRUE)[[1]]})
    summ$run_id = runID[nrow(runID),]
    sampleID = sapply(sapply(summ$sample,function(s){strsplit(s,'?',fixed=TRUE)[[1]][1]}),function(s){strsplit(s,'/',fixed=TRUE)[[1]]})
    summ$sample_id = sampleID[nrow(sampleID),]
    rownames(summ)=summ$run_id
    attr(summ,"project.id")=projectID
    summ
}

getProjectSummary<-function(projectID) {
    url=paste(baseURL,"studies",projectID,"analyses?include=sample&format=csv",sep="/")
    summ=read.project.csv(url,projectID)
    summ
}

projectSamples<-function(summ) {
    unique(sort(summ$sample_id))
}

projectRuns<-function(summ) {
    summ$run_id
}

runsBySample<-function(summ,sampleID) {
    summ$run_id[summ$sample_id == sampleID]
}

otu.url <- function(runID) {
    analysisURL = paste(baseURL,"runs",runID,"analyses?format=csv",sep="/")
    analysis = read.csv(analysisURL,stringsAsFactors=FALSE)
    aurl = analysis$url
    ##message(aurl) # DEBUG
    stem = strsplit(aurl,'?',fixed=TRUE)[[1]][1]
    durl = paste(stem,"downloads?format=csv",sep="/")
    ##message(durl) # DEBUG
    downloads = read.csv(durl,stringsAsFactors=FALSE)
    downloads = downloads[substr(downloads$group_type,1,3)=="Tax",]
    otuurl = downloads$url[grep("otu.tsv",downloads$id[substr(downloads$group_type,1,3)=="Tax"],ignore.case=TRUE)]
    if (length(otuurl)>1)
        otuurl = otuurl[grep("SSU",otuurl)][1]
    ##message(otuurl) # DEBUG
    otuurl
    }

read.otu.tsv<-function(fileName,...) {
    otu = read.delim(fileName,header=FALSE,skip=2,colClasses=c("character","numeric","character"),stringsAsFactors=FALSE,...)
    names(otu) = c("OTU","Count","Tax")
    rownames(otu) = otu$OTU
    otu[order(-otu$Count),]
}

getRunOtu<-function(runID,verb=FALSE,plot.preston=FALSE) {
    url=otu.url(runID)
    ##message(url) # DEBUG
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
        otu=getRunOtu(run,plot.preston=plot.preston)
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
    selectMethod("plot","rad")(rad(comm),main="Rank abundance")
    par(op)
}

intSolve <- function(f,l,h){
    if (abs(l-h) < 2) {
        h
    } else {
        m = round((l+h)/2)
        if (f(m) < 0)
            intSolve(f,m,h)
        else
            intSolve(f,l,m)
    }
}

analyseOtu <- function(otu,plot=TRUE) {
    ns = dim(otu)[1]
    ni = sum(otu$Count)
    sh = diversity(otu$Count)
    fa = fisher.alpha(otu$Count)
    er = estimateR(otu$Count)
    vln = veiledspec(prestondistr(otu$Count))
    tad = convertOtuTad(otu)
    br = breakaway(tad,print=FALSE,plot=FALSE,answers=TRUE)
    mod = fitsad(otu$Count,"poilog")
    p0 = dpoilog(0,mod@coef[1],mod@coef[2])
    pln = ns/(1-p0)
    coverage = function(x){1-dpoilog(0,mod@coef[1]+log(x/ni),mod@coef[2])}
    qs = c(0.75,0.90,0.95,0.99)
    Ls = sapply(qs,function(q){intSolve(function(x){coverage(x)-q},1,10^12)})
    if (plot)
        plotOtu(otu)
    c(
        "S.obs" = ns,
        "N.obs" = ni,
        "Shannon.index" = sh,
        "Fisher.alpha" = fa,
        er["S.chao1"],
        er["se.chao1"],
        er["S.ACE"],
        er["se.ACE"],
        "S.break" = br$est,
        "se.break" = br$se,
        "S.vln" = unname(vln[1]),
        "S.pln" = pln,
        "N.75" = Ls[1],
        "N.90" = Ls[2],
        "N.95" = Ls[3],
        "N.99" = Ls[4]
    )
}








## eof


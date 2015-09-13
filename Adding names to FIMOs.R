##Getting a gene table 

Genes<-read.table(file ="~/Informatics/Ref/genes.txt", sep="\t",header=TRUE, quote="")
colnames(Genes)[1]<-"id"

for (i in c(5,6,10,15,17,22,24,25,29,32,36,37,38,44,46,48,49)){
	name<-paste("FIMO/MotifsCl",i,"In/fimo.txt",sep="")
	x<-read.table(file=name, sep="\t",header=FALSE, quote="")
	colnames(x)<-c("pattern_name", "id", "start", "stop", "strand", "score", "p-value", "q-value", "matched sequence")
	y<-merge(x,Genes[,c(1,4)], by.x="id", all.x=TRUE)
	write.table(y, file=paste("FIMO/fimo",i,".csv",sep=""), sep="," )
}


for (i in c(5,6,10,15,17,22,24,25,29,30,32,36,37,38,41,44,46,48,49)){
	name<-paste("FIMO/MotifsCl",i,"Per/fimo.txt",sep="")
	x<-read.table(file=name, sep="\t",header=FALSE, quote="")
	colnames(x)<-c("pattern_name", "id", "start", "stop", "strand", "score", "p-value", "q-value", "matched sequence")
	y<-merge(x,Genes[,c(1,4)], by.x="id", all.x=TRUE)
	write.table(y, file=paste("FIMO/lfimo",i,".csv",sep=""), sep="," )
}


x<-read.table(file ="FIMO/MotifsCl32In/fimo.txt", sep="\t",header=FALSE, quote="")

colnames(x)<-c("pattern_name", "id", "start", "stop", "strand", "score", "p-value", "q-value", "matched sequence")

x<-merge(newsets[[i]],Genes[,c(1,4)], by="id", all.x=TRUE)	

###Download gene list

clusters<-read.table(file= "Clustering/ClustersFinal.csv", sep=",", header=TRUE)[,2:4]
allGenes<-clusters[,1]
nclus<-list()

for (i in 1:49){
	nclus[[i]]<-as.character(clusters[clusters$cluster==i,1])
}


###Download the lists
sets<-read.table(file="~/Informatics/Ref/StolenDatasets.csv", sep=",",header=TRUE)

###Prpare the table with numers of overlapping genes in each set

Counts<-rep(NA, times=ncol(sets))
dim(Counts)<-c(ncol(sets),1)
Counts<-as.data.frame(Counts, row.names=colnames(sets) )
Counts<-rbind(Counts,all=NA)

for (j in 1:49){
	for (i in 1:ncol(sets)){
		list<-sets[,i]
		Counts[i,j]<-table(nclus[[j]] %in% list)[2]
	}
	Counts[nrow(Counts),j]<-length(nclus[[j]])
}

Counts[nrow(Counts),ncol(Counts)+1]<-length(allGenes)

for (i in 1:ncol(sets)){
	list<-(sets)[,i]
	Counts[i,ncol(Counts)]<-table(allGenes %in% list)[2]
}


Counts[is.na(Counts)]<-0


####Fisher test for all enrichement forms

results<-rep(NA, times=ncol(sets))
dim(results)<-c(ncol(sets),1)
results<-as.data.frame(results, row.names=colnames(sets))


for(j in 1:49){
	for (i in 1:ncol(sets)){
		test<-fisher.test(rbind(Counts[i,c(j,ncol(Counts))],Counts[ncol(sets),c(j,ncol(Counts))]-Counts[i,c(j,ncol(Counts))]))
		results[i,j]<-test$p.value

	}
}

results2<-results

for (i in 1:ncol(results))
results2[,i]<-p.adjust(results[,i])

write.table(results2,file="after adjustement.csv", sep=",")

write.table(results,file="beforeadjustement.csv", sep=",")
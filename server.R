##################################################################################
library(shiny)
library(hexbin)
library(scatterplot3d)
library(ape)
library(ChemmineR)
library(ctc)
#################################################################################
load("MicrosourceSpectrum_coord.rda")
load("MicrosourceSpectrum_sdfset.rda")
#load("MicrosourceSpectrum_apset.rda")
load("MicrosourceSpectrum_distmat.rda")
#load("MicrosourceSpectrum_cids.rda")
#tree<-read.tree("MicrosourceSpectrum_hclust.newick")
load("MicrosourceSpectrum_fpset.rda")
################################################
shinyServer(function(input,output){
#coord2d <-cbind(coord[,1],coord[,2])
#################################################
output$main_plot <- renderPlot({
coord<-subset(coord,coord[,4]<input$clid)
coord2d <-cbind(coord[,1],coord[,2])
plot(hexbin(coord2d[,1], coord2d[,2] ,input$obs))
#################################################
output$MDS_plot<- renderPlot({
coord<-subset(coord,coord[,4]<input$clid)
s3d <- scatterplot3d(coord[,1], coord[,2], coord[,3])
s3d.coords <- s3d$xyz.convert(coord[,1], coord[,2], coord[,3]) 
#text(s3d.coords$x, s3d.coords$y,labels=row.names(coord),cex=.50, pos=4)
})
#################################################
output$hclust_plot <- renderPlot({
	fpset<-fpset[names(fpSim(fpset[input$cmp_view], fpset, method="Tanimoto", cutoff=input$CutOff, top=input$hits))]
	simMA <- sapply(cid(fpset), function(x) fpSim(fpset[x], fpset, sorted=FALSE))
	hc <- hclust(as.dist(1-simMA), method="single")
	plot(hc)
})
#################################################
output$summary<-renderPrint({
SimScore <- fpSim(x=fpset[input$cmp_view], y=fpset[input$QueryB], method="Tanimoto")
print(SimScore)
})
#################################################
output$coord_table<-renderTable({
coord<-subset(coord,coord[,4]<input$clid)
data.frame(coord)
})
#################################################
output$sunflower_plot<-renderPlot({
coord<-subset(coord,coord[,4]<input$clid)
sunflowerplot(coord[,1], coord[,2])
})
################################################
output$compound_matrix<-renderPlot({
plot(sdfset[input$cmp_view])
})
#################################################
output$compound_matrixB<-renderPlot({
fpset<-fpset[names(fpSim(fpset[input$cmp_view], fpset, method="Tanimoto", cutoff=input$CutOff, top=input$hits))]
sdfset<-sdfset[cid(sdfset)%in%cid(fpset)]
plot(sdfset[1:input$hits])
})
#################################################
})
###################################################################################
})


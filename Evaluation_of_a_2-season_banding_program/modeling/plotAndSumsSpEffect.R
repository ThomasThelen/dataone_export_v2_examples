#### Function to do plots and other summaries from Brownie model runs ####
plotAndSumsSpEffect <- function(sim.sum, species=NULL, plotType){
  #### Create ABDU results for plotting ####
  # colnum is 12 if runjags, 6 if jagsUI
  sim.sum$param<-"v"
  for(i in 1:96){
    sim.sum[i,12]<-"SH"
  }
  for(i in 97:192){
    sim.sum[i,12]<-"SN"
  }
  for(i in 193:288){
    sim.sum[i,12]<-"S"
  }
  for(i in 289:396){ # A LOT more now!!
    sim.sum[i,12]<-"f"
  }
  #for(i in 396:402){
   # sim.sum[i,12]<-"mu"
  #}
  
  # add year
  x<-as.matrix(rep(2009:2016, each=3, length=288)) # for SH, SN, S # Incorrect!!
  y<-as.matrix(rep(2009:2017, each=3, length=108)) # for f
  #z <- as.matrix(c(1,2,3,4,5,6)) # for mu
  year<-rbind(x,y)#,z)
  sim.sum<-cbind(sim.sum,year)
  
  # add cohort
  AM<-as.matrix(rep("AM",length=24))
  AF<-as.matrix(rep("AF",length=24))
  JM<-as.matrix(rep("JM",length=24))
  JF<-as.matrix(rep("JF",length=24))
  
  SN<-rbind(AM, AF, JM, JF)
  SH<-rbind(SN, AM, AF, JM, JF)
  S<-rbind(SH,AM, AF, JM, JF)
  
  AMf<-as.matrix(rep("AM",length=27))
  AFf<-as.matrix(rep("AF",length=27))
  JMf<-as.matrix(rep("JM",length=27))
  JFf<-as.matrix(rep("JF",length=27))
  
  f1<-rbind(AMf,AFf,JMf,JFf)
  
  cohort<-rbind(S,f1)
  
  #cohort <- c(cohort, c("ABDU", "HYBR", "MALL", "ABDU", "HYBR", "MALL"))
  
  #cohort <- cohort[1:402] # I guess! Yoink
  
  sim.sum<-cbind(sim.sum,cohort)
  sim.sum$spp<-rep(c("ABDU", "HYBR", "MALL"),length=nrow(sim.sum))
  
  # create cohort specific data sets 
  # ^ Have species as a function option - except for f plots??
  AM.SH<-subset(sim.sum,cohort=="AM" & param=="SH" & spp==species) 
  AF.SH<-subset(sim.sum,cohort=="AF" & param=="SH" & spp==species)
  JM.SH<-subset(sim.sum,cohort=="JM" & param=="SH" & spp==species)
  JF.SH<-subset(sim.sum,cohort=="JF" & param=="SH" & spp==species)
  
  AM.SN<-subset(sim.sum,cohort=="AM" & param=="SN" & spp==species) 
  AF.SN<-subset(sim.sum,cohort=="AF" & param=="SN" & spp==species)
  JM.SN<-subset(sim.sum,cohort=="JM" & param=="SN" & spp==species)
  JF.SN<-subset(sim.sum,cohort=="JF" & param=="SN" & spp==species)
  
  AM.S<-subset(sim.sum,cohort=="AM" & param=="S" & spp==species) 
  AF.S<-subset(sim.sum,cohort=="AF" & param=="S" & spp==species)
  JM.S<-subset(sim.sum,cohort=="JM" & param=="S" & spp==species)
  JF.S<-subset(sim.sum,cohort=="JF" & param=="S" & spp==species)
  
  
  # This part is not by species in the same way!!!
  ABDU.AM.f<-subset(sim.sum,cohort=="AM" & param=="f" & spp=="ABDU") 
  ABDU.AF.f<-subset(sim.sum,cohort=="AF" & param=="f" & spp=="ABDU")
  ABDU.JM.f<-subset(sim.sum,cohort=="JM" & param=="f" & spp=="ABDU")
  ABDU.JF.f<-subset(sim.sum,cohort=="JF" & param=="f" & spp=="ABDU")
  
  HYBR.AM.f<-subset(sim.sum,cohort=="AM" & param=="f" & spp=="HYBR") 
  HYBR.AF.f<-subset(sim.sum,cohort=="AF" & param=="f" & spp=="HYBR")
  HYBR.JM.f<-subset(sim.sum,cohort=="JM" & param=="f" & spp=="HYBR")
  HYBR.JF.f<-subset(sim.sum,cohort=="JF" & param=="f" & spp=="HYBR")
  
  MALL.AM.f<-subset(sim.sum,cohort=="AM" & param=="f" & spp=="MALL") 
  MALL.AF.f<-subset(sim.sum,cohort=="AF" & param=="f" & spp=="MALL")
  MALL.JM.f<-subset(sim.sum,cohort=="JM" & param=="f" & spp=="MALL")
  MALL.JF.f<-subset(sim.sum,cohort=="JF" & param=="f" & spp=="MALL")
  
  if(plotType=="surv"){
  #### ABDU plots ####
  library(gplots)
  par(oma=c(4,1,1,1)) # make outer margin at the bottomm large to accomodate legend
  # Create the multi=panel figure.
  par(mfrow=c(2,2))
  # --- AM ---#
  plotCI(AM.S$year+0.25,
         y=AM.S$Median,
         uiw= AM.S$Upper95 - AM.S$Median,
         liw= AM.S$Median - AM.S$Lower95,
         gap=0.05,
         ylab="Annual Survival", 
         ylim=c(0,1), 
         xlim=c(2008.5,2016.5),
         xlab="Year",col="Black", 
         xaxt="n",
         cex.lab=0.78)
  axis(1, at=seq(2009,2016,1),las=1)
  title(main=paste0(species, " Adult Male (AHY or ASY)"), cex.main=0.8)
  
  par(new=T)
  
  plotCI(x=AM.SH$year-0.25,
         y=AM.SH$Median,
         uiw= AM.SH$Upper95 - AM.SH$Median,
         liw= AM.SH$Median - AM.SH$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Orange")
  
  par(new=T)
  
  plotCI(x= AM.SN$year,
         y= AM.SN$Median,
         uiw= AM.SN$Upper95 - AM.SN$Median,
         liw= AM.SN$Median - AM.SN$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Blue")
  
  # --- ---- AF --- ---- #
  
  plotCI(AF.S$year+0.25,
         y=AF.S$Median,
         uiw=AF.S$Upper95 - AF.S$Median,
         liw=AF.S$Median - AF.S$Lower95,
         gap=0.05,
         ylab="Annual Survival", 
         ylim=c(0,1), 
         xlim=c(2008.5,2016.5),
         xlab="Year",col="Black", 
         xaxt="n",
         cex.lab=0.78)
  axis(1, at=seq(2009,2016,1),las=1)
  title(main=paste0(species, " Adult Female (AHY or ASY)"), cex.main=0.8)
  
  par(new=T)
  
  plotCI(x=AF.SH$year-0.25,
         y=AF.SH$Median,
         uiw=AF.SH$Upper95 - AF.SH$Median,
         liw=AF.SH$Median - AF.SH$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Orange")
  
  par(new=T)
  
  plotCI(x=AF.SN$year,
         y=AF.SN$Median,
         uiw=AF.SN$Upper95 - AF.SN$Median,
         liw=AF.SN$Median - AF.SN$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Blue")
  
  # --- ---- JM --- ---- #
  
  plotCI(JM.S$year+0.25,
         y=JM.S$Median,
         uiw=JM.S$Upper95-JM.S$Median,
         liw=JM.S$Median-JM.S$Lower95,
         gap=0.05,
         ylab="Annual Survival", 
         ylim=c(0,1), 
         xlim=c(2008.5,2016.5),
         xlab="Year",col="Black", 
         xaxt="n",
         cex.lab=0.78)
  axis(1, at=seq(2009,2016,1),las=1)
  title(main=paste0(species, " Juvenile Male (HY or SY)"), cex.main=0.8)
  
  par(new=T)
  
  plotCI(x=JM.SH$year-0.25,
         y=JM.SH$Median,
         uiw=JM.SH$Upper95 - JM.SH$Median,
         liw=JM.SH$Median - JM.SH$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Orange")
  
  par(new=T)
  
  plotCI(x=JM.SN$year,
         y=JM.SN$Median,
         uiw=JM.SN$Upper95 - JM.SN$Median,
         liw=JM.SN$Median - JM.SN$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Blue")
  
  
  # --- ---- JF --- ---- #
  
  plotCI(JF.S$year+0.25,
         y=JF.S$Median,
         uiw=JF.S$Upper95 - JF.S$Median,
         liw=JF.S$Median - JF.S$Lower95,
         gap=0.05,
         ylab="Annual Survival", 
         ylim=c(0,1), 
         xlim=c(2008.5,2016.5),
         xlab="Year",col="Black", 
         xaxt="n",
         cex.lab=0.78)
  axis(1, at=seq(2009,2016,1),las=1)
  title(main=paste0(species, " Juvenile Female (HY or SY)"), cex.main=0.8)
  
  par(new=T)
  
  plotCI(x=JF.SH$year-0.25,
         y=JF.SH$Median,
         uiw=JF.SH$Upper95 - JF.SH$Median,
         liw=JF.SH$Median - JF.SH$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Orange")
  
  par(new=T)
  
  plotCI(x=JF.SN$year,
         y=JF.SN$Median,
         uiw=JF.SN$Upper95 - JF.SN$Median,
         liw=JF.SN$Median - JF.SN$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Blue")
  
  #overlay the entire region with a new single plot, then #call legend  with the location (e.g., "bottom")
  par(fig = c(0,1,0,1), oma=c(0,0,0,0), mar=c(0,0,0,0), new=TRUE)
  plot(0,0,type="n",bty="n", xaxt="n",yaxt="n")
  legend("bottom",c("Seasonal Survival (Aug-Jan)",
                    "Seasonal Survival (Jan-Aug)",
                    "Annual Survival"),
         xpd=TRUE,
         hori=TRUE,
         inset=c(0,0),
         bty="n",
         lty=c(1,1,1),
         col=c("Orange","blue","black"))
  } else { # Recovery probs case
##### Recovery probs because why not? ####
  #dev.off()
  par(oma=c(4,1,1,1)) # make outer margin at the bottomm large to accomodate legend
  # Create the multi=panel figure.
  par(mfrow=c(2,2))
  # --- AM ---#
  plotCI(ABDU.AM.f$year,
         y=ABDU.AM.f$Median,
         uiw= ABDU.AM.f$Upper95 - ABDU.AM.f$Median,
         liw= ABDU.AM.f$Median - ABDU.AM.f$Lower95,
         gap=0.05,
         ylab="Annual Recovery", 
         ylim=c(0,0.5), 
         xlim=c(2008.5,2017.5),
         xlab="Year",col="purple", 
         xaxt="n",
         cex.lab=0.78)
  axis(1, at=seq(2009,2017,1),las=1)
  title(main="Adult Male (AHY or ASY)", cex.main=0.8)
  
  par(new=T)
  
  plotCI(x=HYBR.AM.f$year-0.25,
         y=HYBR.AM.f$Median,
         uiw=HYBR.AM.f$Upper95 - HYBR.AM.f$Median,
         liw=HYBR.AM.f$Median - HYBR.AM.f$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Orange")
  
  par(new=T)
  
  plotCI(x=MALL.AM.f$year+0.25,
         y=MALL.AM.f$Median,
         uiw=MALL.AM.f$Upper95 - MALL.AM.f$Median,
         liw=MALL.AM.f$Median - MALL.AM.f$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="darkgreen")

  # --- ---- AF --- ---- #
  
  plotCI(ABDU.AF.f$year,
         y=ABDU.AF.f$Median,
         uiw= ABDU.AF.f$Upper95 - ABDU.AF.f$Median,
         liw= ABDU.AF.f$Median - ABDU.AF.f$Lower95,
         gap=0.05,
         ylab="Annual Recovery", 
         ylim=c(0,0.5), 
         xlim=c(2008.5,2017.5),
         xlab="Year",col="purple", 
         xaxt="n",
         cex.lab=0.78)
  axis(1, at=seq(2009,2017,1),las=1)
  title(main="Adult Female (AHY or ASY)", cex.main=0.8)
  
  par(new=T)
  
  plotCI(x=HYBR.AF.f$year-0.25,
         y=HYBR.AF.f$Median,
         uiw=HYBR.AF.f$Upper95 - HYBR.AF.f$Median,
         liw=HYBR.AF.f$Median - HYBR.AF.f$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Orange")
  
  par(new=T)
  
  plotCI(x=MALL.AF.f$year+0.25,
         y=MALL.AF.f$Median,
         uiw=MALL.AF.f$Upper95 - MALL.AF.f$Median,
         liw=MALL.AF.f$Median - MALL.AF.f$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="darkgreen")
  
  # --- ---- JM --- ---- #
  
  plotCI(ABDU.JM.f$year,
         y=ABDU.JM.f$Median,
         uiw= ABDU.JM.f$Upper95 - ABDU.JM.f$Median,
         liw= ABDU.JM.f$Median - ABDU.JM.f$Lower95,
         gap=0.05,
         ylab="Annual Recovery", 
         ylim=c(0,0.5), 
         xlim=c(2008.5,2017.5),
         xlab="Year",col="purple", 
         xaxt="n",
         cex.lab=0.78)
  axis(1, at=seq(2009,2017,1),las=1)
  title(main="Juvenile Male (HY or SY)", cex.main=0.8)
  
  par(new=T)
  
  plotCI(x=HYBR.JM.f$year-0.25,
         y=HYBR.JM.f$Median,
         uiw=HYBR.JM.f$Upper95 - HYBR.JM.f$Median,
         liw=HYBR.JM.f$Median - HYBR.JM.f$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Orange")
  
  par(new=T)
  
  plotCI(x=MALL.JM.f$year+0.25,
         y=MALL.JM.f$Median,
         uiw=MALL.JM.f$Upper95 - MALL.JM.f$Median,
         liw=MALL.JM.f$Median - MALL.JM.f$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="darkgreen")

  # --- ---- JF --- ---- #
  
  plotCI(ABDU.JF.f$year,
         y=ABDU.JF.f$Median,
         uiw= ABDU.JF.f$Upper95 - ABDU.JF.f$Median,
         liw= ABDU.JF.f$Median - ABDU.JF.f$Lower95,
         gap=0.05,
         ylab="Annual Recovery", 
         ylim=c(0,0.5), 
         xlim=c(2008.5,2017.5),
         xlab="Year",col="purple", 
         xaxt="n",
         cex.lab=0.78)
  axis(1, at=seq(2009,2017,1),las=1)
  title(main="Juvenile Female (HY or SY)", cex.main=0.8)
  
  par(new=T)
  
  plotCI(x=HYBR.JF.f$year-0.25,
         y=HYBR.JF.f$Median,
         uiw=HYBR.JF.f$Upper95 - HYBR.JF.f$Median,
         liw=HYBR.JF.f$Median - HYBR.JF.f$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="Orange")
  
  par(new=T)
  
  plotCI(x=MALL.JF.f$year+0.25,
         y=MALL.JF.f$Median,
         uiw=MALL.JF.f$Upper95 - MALL.JF.f$Median,
         liw=MALL.JF.f$Median - MALL.JF.f$Lower95,
         gap=0.05, 
         ann=FALSE,
         add=T, 
         col="darkgreen")
  
  par(fig = c(0,1,0,1), oma=c(0,0,0,0), mar=c(0,0,0,0), new=TRUE)
  plot(0,0,type="n",bty="n", xaxt="n",yaxt="n")
  legend("bottom",c("Hybrid (HYBR)",
                    "Mallard (MALL)",
                    "Black duck (ABDU)"),
         xpd=TRUE,
         hori=TRUE,
         inset=c(0,0),
         bty="n",
         lty=c(1,1,1),
         col=c("Orange","darkgreen","purple"))  

  }
  # if you return tables or anything, could try doing that here
  # Return one data set that's the survival subsets in a data frame, one per column
  # # Then another data set that's the recovery subsets
  # surv.probs <- data.frame(ham=AM.SH$Median, haf=AF.SH$Median, 
  #                           hjm=JM.SH$Median, hjf=JF.SH$Median,
  #                           nam=AM.SN$Median, naf=AF.SN$Median,
  #                           njm=JM.SN$Median, njf=JF.SN$Median,
  #                           sam=AM.S$Median, saf=AF.S$Median,
  #                           sjm=JM.S$Median, sjf=JF.S$Median)
  #  recov.probs <- data.frame(fam=AM.f$Median, faf=AF.f$Median,
  #                            fjm=JM.f$Median, fjf=JF.f$Median)
  #return(list(surv.probs=surv.probs, recov.probs=recov.probs, sim.sum=sim.sum))
  #return(sim.sum)
  #return(list(AM.SH=AM.SH, AF.SH=AF.SH, 
  #            JM.SH=JM.SH, JF.SH=JF.SH,
  #            AM.SN=AM.SN, AF.SN=AF.SN,
  #            JM.SN==JM.SN, JF.SN=JF.SN,
  #            AM.S=AM.S, AF.S=AF.S,
  #            JM.S=JM.S, JF.S=JF.S,
  #            AM.f=AM.f, AF.f=AF.f, 
  #            JM.f=JM.f, JF.f=JF.f))
}

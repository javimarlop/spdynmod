mrgf_ft95<-function(w1=3,w2=15,k=0.1){

ft95<<-NULL
es<-NULL

fwe3<-fitw3_95*exp(-k*(3-1))
fwe5<-fitw5_95*exp(-k*(5-1))
fwe7<-fitw7_95*exp(-k*(7-1))
fwe9<-fitw9_95*exp(-k*(9-1))
fwe11<-fitw11_95*exp(-k*(11-1))
fwe13<-fitw13_95*exp(-k*(13-1))
fwe15<-fitw15_95*exp(-k*(15-1))

num<-fwe3+fwe5+fwe7+fwe9+fwe11+fwe13+fwe15
print(num)
h<-0
 for(i in seq(w1,w2,2)){
  h<-h+1
  ee<-exp(-k*(i-1))
  es[h]<-ee
 }

print(es)
den<-sum(es,na.rm=T)
print(den)

ft95<-num/den
ft95

}

'=====
'Title: this is a program to forecast using Exponential Smoothing
'Author: Fadhilah Nur Binti Ismail
'Matric Number : A167808
'Date: 12 May 2020 (Tuesday)
'=====

close @all
logmode l    'untuk bagi mesej kepada eviews

%path = @runpath 'untuk directkan path ke direktori
cd %path  'untuk tukar direktori path yang lain, so kat laptop org lain pon boleh run
%xlsdata = "es.xlsx"
%pathxlsdata = %path+%xlsdata
%file = "Dila"  'untuk namakan file 

'date will following US system
%dat_start ="2/1/2010" ' start data 1Feb 2010
%dat_end ="3/19/2020" 'end data 19 Mac 2020
%fcst_start ="3/20/2020" 'start forecasting 20 Mac 2020
%fcst_end ="9/30/2020" 'end forecasting 30 Sept 2020: end of third quarter 2020

 'create workfile, d5 ialah 5 hari seminggu
wfcreate(wf={%file}) d5 %dat_start %fcst_end
pagerename Untitled {%file}

string sheet1 = "data" 'namakan data sebab nama excel sheet tu ialah DATA

'import data,
'series 01 sebab takde nama atas colum date
for %a {sheet1}
import %pathxlsdata range=%a colhead=1 na="#N/A" @freq d5 @id @date(series01) @destid @date @smpl @all
next

logmsg done importing {%file}

'proses nak buat Exponential smoothing

%b ="usd"
freeze(stat{%b}) {%b}.stats
graph graph{%b}.line {%b}

series l{%b} = log({%b})
freeze(statl{%b}) l{%b}.stats 'nak dapatkan diskiptif statistik untuk log
graph graphl{%b}.line l{%b}

logmsg done descriptive statistic and graph {%file}

'Exponential Smoothing Model
smpl %dat_start %dat_end

'freeze(tab1) l{%b}.ets(e=m, t=md, s=e, cycle=2) l{%b}_sm
freeze(tab1) l{%b}.ets(e=a, t=e, s=e,amse, cycle=2) l{%b}_sm
'tb3.ets(e=a, t=e, s=e, amse,
smpl @all
series {%b}_sm = @exp(l{%b}_sm)
group g1 {%b} {%b}_sm

%h ="smooth"
graph {%h}.line g1
 {%h}.addtext(ac, textcolor(@rgb(0,0,0)), fillcolor(@rgb(255,255,255)),framecolor(@rgb(0,0,0)),just(c),font(Arial,14,-brent,-i,-usd,-sheet1)) "Actual vs.Smooth" 'tajuk graph

show {%h}

logmsg Fadhilah has finish the Tutorial Extra 1 
logmsg Thank you Sir Harun for your video and guideline :)

wfsave {%file}


(* ::Package:: *)

(* ::Input:: *)
(*EPS=10^-18;*)
(*(* Rosenbrock function *)*)
(*\[Alpha]=100;*)
(*rosenbrock[{x_,y_}]:=\[Alpha] (x^2-y)^2+(x-1)^2;*)
(**)
(*(* Quadratic function *)*)
(*func3[{x_,y_}]:=5x^2+2y^2+4x y + 4Sqrt[5](x+y)-14;*)
(**)
(*(* Function selection *)*)
(*f=rosenbrock;*)
(*(* Method selection *)*)
(*(* 1 - Regular simplex method *)*)
(*(* 2 - Downhill simplex method (Nelder\[Dash]Mead method) *)*)
(*method=2;*)
(*(* Max iterations allowed before calling Abort[] *)*)
(*maxIterations=90000;*)
(*(* Precision *)*)
(*\[CurlyEpsilon]=10^-7;*)
(*(* Starting point *)*)
(*\[GothicCapitalX]0={-1,-2};*)
(**)
(*Framed@Framed@"Function"*)
(*Row@{"f(x, y) = ",TraditionalForm@f[{x,y}]}*)
(*Framed@Framed@"Method"*)
(*methodNames={"Regular simplex method","Downhill simplex method (Nelder\[Dash]Mead method)"};*)
(*Print@methodNames[[method]];*)
(**)
(*(* Helper functions *)*)
(*antiGradF[{x_,y_}]:=-Grad[f@{x1,x2},{x1,x2}]/.{x1->x,x2->y};*)
(*normGradF[{x_,y_}]:=Norm@antiGradF@{x,y};*)
(*hessian[{x_,y_}]:=D[f@{x1,x2},{{x1,x2},2}]/.{x1->x,x2->y};*)
(**)
(*(* Init variables *)*)
(*\[CapitalXi]points = {};*)
(*\[CapitalXi]norms={};*)
(*plotToPoint = 1;*)
(*MethodDivergedError=False;*)
(**)
(*(* Plot with "residual norms" aka simplex size ||L||, changes dynamically *)*)
(*Framed@Framed@"Simplex size plot"*)
(*Dynamic@ListLogPlot[EPS+\[CapitalXi]norms[[1;;plotToPoint]],*)
(*AxesLabel->{"Iteration k", "||L||"},*)
(*AxesStyle->Directive[Black,Thick],*)
(*Ticks->{Automatic,{10^#,Superscript["10",#]}&/@FindDivisions[{Floor@Log10@#1,Ceiling@Log10@#2,1},8]&},*)
(*PlotStyle->{Blue,Thick},*)
(*MeshStyle->Directive[PointSize@0.02,Red],*)
(*Joined->True,*)
(*Mesh->Full,*)
(*PlotRange->{Min[\[CurlyEpsilon]/10,If[Last@\[CapitalXi]norms>0,Last@\[CapitalXi]norms/10,EPS/10]],2First@\[CapitalXi]norms},*)
(*LabelStyle->Large,*)
(*ImageSize->600,*)
(*(* y = \[CurlyEpsilon] line *)*)
(*Epilog-> {Thickness@0.004,Purple,*)
(*Line@{{1,Log@\[CurlyEpsilon]},{Length@\[CapitalXi]norms,Log@\[CurlyEpsilon]}},*)
(*Text[Style["\[CurlyEpsilon]",FontSize->24,Black],{1+0.05(Length@\[CapitalXi]norms-1),Log[2\[CurlyEpsilon]]}]}*)
(*]*)
(**)
(*(* ################################ *)*)
(*(* ##### Regular simplex method ##### *)*)
(*(* ################################ *)*)
(*MethodRegularSimplex:=Module[{n=2,L=2.0,\[Delta]=1/2,X,X0=\[GothicCapitalX]0,FVal,sortFVal,order,XNext,FNext},*)
(*k=0;*)
(**)
(*(* Simplex vertices *)*)
(*X=Table[If[j<i-1,X0[[j]],If[j==i-1,X0[[j]]+L Sqrt[j/(2(j+1))],X0[[j]]-L/Sqrt[2 j(j+1)]]],{i,1,n+1},{j,1,n}];*)
(*(* Function values at vertices *)*)
(*FVal=f/@X;*)
(*(* Sort vertives to ensure "correct ordering" *)*)
(*sortFVal=Sort[FVal];*)
(*order=Table[Position[FVal,sortFVal[[i]]][[1,1]],{i,1,n+1}];*)
(*X=Table[X[[i]],{i,order}];*)
(**)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]norms~AppendTo~L;*)
(*plotToPoint=k+1;*)
(**)
(*While[L>\[CurlyEpsilon],*)
(*k++;*)
(**)
(*(* Reflect the vertex with maximal value of f() *)*)
(*XNext=2/n \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n\)]\(X[\([i]\)]\)\)-X[[n+1]];*)
(*FNext=f[XNext];*)
(*(* If reflection was unsuccesfull, reduce simplex size *)*)
(*If[FNext>= sortFVal[[-1]],*)
(*L=L \[Delta];*)
(*X={X[[1]]}~Join~Table[X[[1]]+\[Delta] (X[[i]]-X[[1]]),{i,2,n+1}];,*)
(*X=Append[Take[X,n],XNext];*)
(*];*)
(*(* Function values at vertices *)*)
(*FVal=f/@X;*)
(*(* Sort vertives to ensure "correct ordering" *)*)
(*sortFVal=Sort[FVal];*)
(*order=Table[Position[FVal,sortFVal[[i]]][[1,1]],{i,1,n+1}];*)
(*X=Table[X[[i]],{i,order}];*)
(**)
(*(* Save for visualization *)*)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]norms~AppendTo~L;*)
(*plotToPoint=k+1;*)
(**)
(*If[k>maxIterations,Print@"ERROR: MAX NUMBER OF ITERATIONS EXCEEDED";Abort[]];*)
(*If[Norm[First@X-\[GothicCapitalX]0]>10^5,Print@"ERROR: \:041cETHOD DIVERGES";MethodDivergedError=True;Abort[]];*)
(*];*)
(*];*)
(**)
(*(* #################################################### *)*)
(*(* ##### Downhill simplex method (Nelder\[Dash]Mead method) ##### *)*)
(*(* #################################################### *)*)
(*MethodNelderMead:=Module[{n=2,L=2.0,\[Alpha]=1,\[Beta]=2,\[Gamma]=1/2,\[Delta]=1/2,X,X0=\[GothicCapitalX]0,FVal,sortFVal,order,Xc,Fc,XNext,FNext,XStretch,FStretch,XCompress,FCompress},*)
(*k=0;*)
(**)
(*(* Simplex vertices *)*)
(*X=Table[If[j<i-1,X0[[j]],If[j==i-1,X0[[j]]+L Sqrt[j/(2(j+1))],X0[[j]]-L/Sqrt[2 j(j+1)]]],{i,1,n+1},{j,1,n}];*)
(*(* Function values at vertices *)*)
(*FVal=f/@X;*)
(*(* Sort vertives to ensure "correct ordering" *)*)
(*sortFVal=Sort[FVal];*)
(*order=Table[Position[FVal,sortFVal[[i]]][[1,1]],{i,1,n+1}];*)
(*X=Table[X[[i]],{i,order}];*)
(*XSort={X};*)
(*Xc=1/n \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(j = 1\), \(n\)]\(X[\([j]\)]\)\);*)
(*Fc=f@Xc;*)
(**)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]norms~AppendTo~Sqrt[1/(n+1) \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n + 1\)]*)
(*\*SuperscriptBox[\((sortFVal[\([i]\)] - Fc)\), \(2\)]\)];*)
(*plotToPoint=k+1;*)
(**)
(*(* Special stopping criteria for downhill method *)*)
(*While[1/(n+1) \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n + 1\)]*)
(*\*SuperscriptBox[\((sortFVal[\([i]\)] - Fc)\), \(2\)]\)>= \[CurlyEpsilon]^2,*)
(*k++;*)
(**)
(*XNext=(1+\[Alpha])/n \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n\)]\(X[\([i]\)]\)\)-\[Alpha] X[[n+1]];*)
(*FNext=f[XNext];*)
(*(* If reflection was succesfull, increase simplex size *)*)
(*If[FNext< sortFVal[[1]],*)
(*XStretch=(1-\[Beta])/n \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n\)]\(X[\([i]\)]\)\)+\[Beta] X[[n+1]];*)
(*FStretch=f[XStretch];*)
(*If[FStretch< sortFVal[[1]],*)
(*X=Append[Take[X,n],XStretch],*)
(*X=Append[Take[X,n],XNext]*)
(*];*)
(*];*)
(*(* Save coords *)*)
(*If[sortFVal[[-2]]>= FNext>= sortFVal[[1]],*)
(*X=Append[Take[X,n],XNext]*)
(*];*)
(*(* If reflection was unsuccesfull, reduce simplex size *)*)
(*If[ FNext>sortFVal[[-2]]>= sortFVal[[1]],*)
(*If[FNext<= sortFVal[[-1]],*)
(*XCompress=(1-\[Gamma])/n \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n\)]\(X[\([i]\)]\)\)+\[Gamma] XNext,*)
(*XCompress=(1-\[Gamma])/n \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n\)]\(X[\([i]\)]\)\)+\[Gamma] X[[n+1]]*)
(*];*)
(*FCompress=f[XCompress];*)
(*If[FCompress< sortFVal[[-1]],*)
(*X=Append[Take[X,n],XCompress],*)
(*(* reduction *)*)
(*L=L \[Delta];*)
(*X={X[[1]]}~Join~Table[X[[1]]+\[Delta] (X[[i]]-X[[1]]),{i,2,n+1}];*)
(*];*)
(*];*)
(*(* Function values at vertices *)*)
(*FVal=f/@X;*)
(*(* Sort vertives to ensure "correct ordering" *)*)
(*sortFVal=Sort[FVal];*)
(*order=Table[Position[FVal,sortFVal[[i]]][[1,1]],{i,1,n+1}];*)
(*X=Table[X[[i]],{i,order}];*)
(*XSort=Append[XSort,X];*)
(*Xc=1/n \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(j = 1\), \(n\)]\(X[\([j]\)]\)\);*)
(*Fc=f[Xc];*)
(**)
(*(* Save for visualization *)*)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]norms~AppendTo~Sqrt[1/(n+1) \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(i = 1\), \(n + 1\)]*)
(*\*SuperscriptBox[\((sortFVal[\([i]\)] - Fc)\), \(2\)]\)];*)
(*plotToPoint=k+1;*)
(**)
(*If[k>maxIterations,Print@"ERROR: MAX NUMBER OF ITERATIONS EXCEEDED";Abort[]];*)
(*If[Norm[First@X-\[GothicCapitalX]0]>10^5,Print@"ERROR: \:041cETHOD DIVERGES";MethodDivergedError=True;Abort[]];*)
(*];*)
(*];*)
(**)
(*(* Launch selected method *)*)
(*If[method==1,MethodRegularSimplex];*)
(*If[method==2,MethodNelderMead];*)
(**)
(*(* Dislay the result *)*)
(*\[GothicCapitalX]=N@First@Last@\[CapitalXi]points;*)
(*Column@{*)
(*Dynamic@Row@{"Display until iteration: ", plotToPoint-1},*)
(*Slider[Dynamic@plotToPoint,{1,Length@\[CapitalXi]norms,1}]*)
(*}*)
(*Row@{"Argmin: \[GothicCapitalX] = ",\[GothicCapitalX]}*)
(*Row@{"Number of iterations: K = ", Length@\[CapitalXi]points - 1}*)
(**)
(*(* Minimized function plot *)*)
(*Framed@Framed@"Minimized function plot (log scale)"*)
(**)
(*center=If[MethodDivergedError,\[GothicCapitalX]0,\[GothicCapitalX]];*)
(*areaSize=If[MethodDivergedError,12,8];*)
(*zOffset=1+Abs@f@center;*)
(**)
(*Plot3D[zOffset+f@{x,y},{x,center[[1]]-areaSize,center[[1]]+areaSize},{y,center[[2]]-areaSize,center[[2]]+areaSize},*)
(*ScalingFunctions->{None,None,"Log10"},*)
(*Ticks->{Automatic,Automatic,{10^#,Superscript["10",#]}&/@FindDivisions[{Floor@Log10@#1,Ceiling@Log10@#2,1},8]&},*)
(*PlotRange->Full,*)
(*ColorFunction->Function[{x,y,z},Hue[.65(1-z)]],*)
(*AxesStyle->Black,*)
(*BoxStyle->Black,*)
(*ImageSize->400*)
(*]*)
(**)
(*(* Contour lines *)*)
(*Framed@Framed@"Contour lines"*)
(*contourToPoint = Length@\[CapitalXi]points;*)
(*Dynamic@ContourPlot[Log10[zOffset+f@{x,y}],{x,center[[1]]-areaSize/zoom,center[[1]]+areaSize/zoom},{y,center[[2]]-areaSize/zoom,center[[2]]+areaSize/zoom},*)
(*ColorFunction->Function[{z},Hue[.65(1-z)]],*)
(*Contours->30,*)
(*ContourStyle->Black,*)
(*ImageSize->400,*)
(*(* display the process *)*)
(*Epilog->{*)
(*(* edges connecting simplex vertices *)*)
(*EdgeForm@{Black,Dashed},Opacity@0.25,Pink,Dynamic@Table[Polygon@\[CapitalXi]points[[i]],{i,1,contourToPoint}],*)
(*(* simplex vertices *)*)
(*Opacity@1,Red,PointSize@0.015,Dynamic@Point@Flatten[\[CapitalXi]points[[1;;contourToPoint]],1],*)
(*(* min point *)*)
(*Black,PointSize@0.02,Point@First@Last@\[CapitalXi]points*)
(*}*)
(*]*)
(*Column@{*)
(*Dynamic@Row@{"Displayed iterations: ",contourToPoint-1},*)
(*Slider[Dynamic@contourToPoint,{1,Length@\[CapitalXi]points,1}],*)
(*Dynamic@Row@{"Zoom: ",zoom},*)
(*Slider[Dynamic@zoom,{1,20,0.01}]*)
(*}*)

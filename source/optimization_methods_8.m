(* ::Package:: *)

(* ::Input:: *)
(*EPS=10^-18;*)
(*(* Rosenbrock function *)*)
(*\[Alpha]=1;*)
(*rosenbrock[{x_,y_}]:=\[Alpha] (x^2-y)^2+(x-1)^2;*)
(**)
(*(* Quadratic function *)*)
(*func3[{x_,y_}]:=5x^2+2y^2+4x y + 4Sqrt[5](x+y)-14;*)
(**)
(*(* Function selection *)*)
(*f=rosenbrock;*)
(*(* Method selection *)*)
(*(* 1 - Interior penalty function method *)*)
(*(* 2 - Exterior penalty function method *)*)
(*method=1;*)
(*(* Max iterations allowed before calling Abort[] *)*)
(*maxIterations=200;*)
(*(*Precision *)*)
(*\[CurlyEpsilon]=10^-3;*)
(*\[CurlyEpsilon]Digits=3(*Ceiling@N@(Log@(1/\[CurlyEpsilon])/Log@10)*);*)
(*(* Starting point *)*)
(*\[GothicCapitalX]0={-1,2};*)
(**)
(*(* Boundary *)*)
(*g[{x_,y_}]:=3/4 (x+0.4)^2+5/4 (x+0.4)-2+y;*)
(**)
(*Framed@Framed@"Function"*)
(*Row@{"f(x, y) = ",TraditionalForm@f[{x,y}]}*)
(*Framed@Framed@"Region"*)
(*Row@{"g(x, y) = ",TraditionalForm@g[{x,y}], " \[LessEqual] 0"}*)
(*Framed@Framed@"Method"*)
(*methodNames={"Interior penalty function method","Exterior penalty function method"};*)
(*Print@methodNames[[method]];*)
(**)
(*(* Helper functions *)*)
(*If[method==1,\[Delta]k[{x_,y_},par_]:=Piecewise[{{-par 1/g@{x,y},g@{x,y}<0},{1/par-par 1/g@{x,y},g@{x,y}>0}},1/par]];*)
(*If[method==2,\[Delta]k[{x_,y_},par_]:=Piecewise[{{0,g@{x,y}<0}},par (g@{x,y})^2]];*)
(**)
(*antiGradF[{x_,y_}]:=-Grad[f@{x1,x2},{x1,x2}]/.{x1->x,x2->y};*)
(*normGradF[{x_,y_}]:=Norm@antiGradF@{x,y};*)
(*hessianF[{x_,y_}]:=D[f@{x1,x2},{{x1,x2},2}]/.{x1->x,x2->y};*)
(**)
(*(* Init variables *)*)
(*\[CapitalXi]points = {};*)
(*\[CapitalXi]norms={};*)
(*\[CapitalXi]values={};*)
(*\[CapitalXi]valuesK={};*)
(*plotToPoint = 1;*)
(*MethodDivergedError=False;*)
(*firstRK=0;*)
(*lastRK=0;*)
(**)
(*(* Plot with residual norms, changes dynamically *)*)
(*Framed@Framed@"Residual plot"*)
(*Dynamic@ListLogPlot[EPS+\[CapitalXi]norms[[1;;plotToPoint]],*)
(*AxesLabel->{"Iteration k", "||w||"},*)
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
(*(* ######################################### *)*)
(*(* ##### Interior penalty function method ##### *)*)
(*(* ######################################### *)*)
(*MethodInternalPenaltyFunc:=Module[{X=\[GothicCapitalX]0,\[Gamma]=0.5},*)
(*k = 0;*)
(**)
(*rk=0.1;*)
(**)
(*\[CapitalXi]points={X};*)
(*\[CapitalXi]values={f@X};*)
(*\[CapitalXi]valuesK={fk@X};*)
(*plotToPoint=k;*)
(**)
(*While[True,*)
(*k++;*)
(**)
(*fk[{x_,y_}]:=f@{x,y}+\[Delta]k[{x,y},rk];*)
(*X={x,y}/.Last@Quiet@FindMinimum[fk@{x,y},{{x,\[GothicCapitalX]0[[1]]},{y,\[GothicCapitalX]0[[2]]}},Method->"ConjugateGradient",AccuracyGoal->\[CurlyEpsilon]Digits];*)
(**)
(*(* Save for visualization *)*)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]values~AppendTo~f@X;*)
(*\[CapitalXi]valuesK~AppendTo~fk@X;*)
(*\[CapitalXi]norms~AppendTo~Norm[\[CapitalXi]valuesK[[-2]]-\[CapitalXi]valuesK[[-1]]];*)
(*plotToPoint=k;*)
(**)
(*rk*=\[Gamma];*)
(**)
(*If[k>maxIterations,Print@"ERROR: MAX NUMBER OF ITERATIONS EXCEEDED";Abort[]];*)
(*If[Norm[First@X-\[GothicCapitalX]0]>10^5,Print@"ERROR: \:041cETHOD DIVERGES";MethodDivergedError=True;Abort[]];*)
(**)
(*If[Abs[\[CapitalXi]valuesK[[-2]]-\[CapitalXi]valuesK[[-1]]]<\[CurlyEpsilon],Break[]];*)
(*];*)
(*];*)
(**)
(*(* ######################################### *)*)
(*(* ##### Exterior penalty function method ##### *)*)
(*(* ######################################### *)*)
(*MethodExternalPenaltyFunc:=Module[{X=\[GothicCapitalX]0,\[Gamma]=1.5},*)
(*k = 0;*)
(**)
(*rk=1.;*)
(**)
(*\[CapitalXi]points={X};*)
(*\[CapitalXi]values={f@X};*)
(*\[CapitalXi]valuesK={fk@X};*)
(*plotToPoint=k;*)
(**)
(*While[True,*)
(*k++;*)
(**)
(*fk[{x_,y_}]:=f@{x,y}+\[Delta]k[{x,y},rk];*)
(*X={x,y}/.Last@Quiet@FindMinimum[fk@{x,y},{{x,\[GothicCapitalX]0[[1]]},{y,\[GothicCapitalX]0[[2]]}},Method->"ConjugateGradient",AccuracyGoal->\[CurlyEpsilon]Digits];*)
(**)
(*(* Save for visualization *)*)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]values~AppendTo~f@X;*)
(*\[CapitalXi]valuesK~AppendTo~fk@X;*)
(*\[CapitalXi]norms~AppendTo~Abs[\[CapitalXi]valuesK[[-2]]-\[CapitalXi]valuesK[[-1]]];*)
(*plotToPoint=k;*)
(**)
(*rk*=\[Gamma];*)
(**)
(*If[k>maxIterations,Print@"ERROR: MAX NUMBER OF ITERATIONS EXCEEDED";Abort[]];*)
(*If[Norm[First@X-\[GothicCapitalX]0]>10^5,Print@"ERROR: \:041cETHOD DIVERGES";MethodDivergedError=True;Abort[]];*)
(**)
(*If[Abs[\[CapitalXi]valuesK[[-2]]-\[CapitalXi]valuesK[[-1]]]<\[CurlyEpsilon],Break[]];*)
(*];*)
(*];*)
(**)
(*(* Launch selected method *)*)
(*If[method==1,MethodInternalPenaltyFunc];*)
(*If[method==2,MethodExternalPenaltyFunc];*)
(**)
(*(* Dislay the result *)*)
(*\[GothicCapitalX]=Last@\[CapitalXi]points;*)
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
(*plotRK =0.0;*)
(**)
(*Dynamic@Plot3D[zOffset+f@{x,y},{x,center[[1]]-areaSize,center[[1]]+areaSize},{y,center[[2]]-areaSize,center[[2]]+areaSize},*)
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
(**)
(*Dynamic@Show[{*)
(*ContourPlot[Log10[zOffset+f@{x,y}],{x,center[[1]]-areaSize/zoom,center[[1]]+areaSize/zoom},{y,center[[2]]-areaSize/zoom,center[[2]]+areaSize/zoom},*)
(*ColorFunction->Function[{z},Hue[.65(1-z)]],*)
(*Contours->30,*)
(*ContourStyle->Black,*)
(*ImageSize->400,*)
(*(* display the process *)*)
(*Epilog->{*)
(*(* arrows *)*)
(*Black,Thickness@0.002,Dynamic@Table[Arrow@\[CapitalXi]points[[i-1;;i]],{i,2,contourToPoint}],*)
(*(* points *)*)
(*Red,PointSize@0.015,Dynamic@Point@\[CapitalXi]points[[1;;contourToPoint]],PointSize@0.02,Point@Last@\[CapitalXi]points,*)
(*(* min point *)*)
(*Blue,PointSize@0.01,Point@Last@\[CapitalXi]points*)
(*}*)
(*],*)
(*ContourPlot[g@{x,y}==0,{x,center[[1]]-areaSize/zoom,center[[1]]+areaSize/zoom},{y,center[[2]]-areaSize/zoom,center[[2]]+areaSize/zoom},*)
(*ContourStyle->Red*)
(*]*)
(*}]*)
(*Column@{*)
(*Dynamic@Row@{"Displayed iterations: ",contourToPoint-1},*)
(*Slider[Dynamic@contourToPoint,{1,Length@\[CapitalXi]points,1}],*)
(*Dynamic@Row@{"Zoom: ",zoom},*)
(*Slider[Dynamic@zoom,{1,20,0.01}]*)
(*}*)
(**)
(*(* Penalty function plot *)*)
(*Framed@Framed@"Penalty function plot"*)
(*If[method==1,firstRK=0.1;lastRK=1;plotRK=0.2;denominatorPower=0.5;]*)
(*If[method==2,firstRK=1;lastRK=20;plotRK=firstRK;denominatorPower=0.0;]*)
(*maxAbs=10^15;*)
(*Dynamic@Plot3D[Max[-maxAbs,Min[\[Delta]k[{x,y},plotRK]/(1+Abs@\[Delta]k[{x,y},plotRK])^denominatorPower,maxAbs]],{x,center[[1]]-areaSize,center[[1]]+areaSize},{y,center[[2]]-areaSize,center[[2]]+areaSize},*)
(*PlotRange->Full,*)
(*ColorFunction->Function[{x,y,z},Hue[.65(1-z)]],*)
(*AxesStyle->Black,*)
(*BoxStyle->Black,*)
(*ImageSize->400*)
(*]*)
(*Column@{*)
(*Dynamic@Row@{"Parameter rk: ",plotRK},*)
(*Slider[Dynamic@plotRK,{Min[firstRK,lastRK],Max[firstRK,lastRK],Abs[firstRK-lastRK]/20}],*)
(*Dynamic@Row@{"Visualization steepness reduction power: ",denominatorPower},*)
(*Slider[Dynamic@denominatorPower,{0.0,0.95,0.05}]*)
(*}*)
(* ::Package:: *)

(* ::Input:: *)
(*EPS=10^-16;*)
(*(* Rosenbrock function *)*)
(*\[Alpha]=1000;*)
(*rosenbrock[{x_,y_}]:=\[Alpha] (x^2-y)^2+(x-1)^2;*)
(**)
(*(* Quadratic function *)*)
(*func3[{x_,y_}]:=5x^2+2y^2+4x y + 4Sqrt[5](x+y)-14;*)
(**)
(*(* Function selection *)*)
(*f=rosenbrock;*)
(*(* Method selection *)*)
(*(* 1 - Nonlinear conjugate gradient method *)*)
(*(* 2 - Fletcher\[Dash]Reeves method *)*)
(*(* 3 - Polak\[Dash]Ribi\[EGrave]re method *)*)
(*(* 4 - Nonlinear conjugate gradient method with Hessian matrix *)*)
(*method=4;*)
(*(* Max iterations allowed before calling Abort[] *)*)
(*maxIterations=200;*)
(*(* Precision *)*)
(*\[CurlyEpsilon]=10^-3;*)
(*(* Starting point *)*)
(*\[GothicCapitalX]0={-1,-2};*)
(**)
(*Framed@Framed@"Function"*)
(*Row@{"f(x, y) = ",TraditionalForm@f[{x,y}]}*)
(*Framed@Framed@"Method"*)
(*methodNames={"Nonlinear conjugate gradient method","Fletcher\[Dash]Reeves method","Polak\[Dash]Ribi\[EGrave]re method","Nonlinear conjugate gradient method with Hessian matrix"};*)
(*Print@methodNames[[method]];*)
(**)
(*(* Helper functions *)*)
(*antiGradF[{x_,y_}]:=-Grad[f@{x1,x2},{x1,x2}]/.{x1->x,x2->y};*)
(*normGradF[{x_,y_}]:=Norm@antiGradF@{x,y};*)
(**)
(*(* Init variables *)*)
(*\[CapitalXi]\[GothicCapitalX]={};(* point *)*)
(*\[CapitalXi]\[Aleph]={};(* value *) *)
(*\[CapitalXi]\[Omega]={};(* vector *)*)
(*\[CapitalXi]\[Gamma]={};(* value *)*)
(*\[CapitalXi]p={};(* vector *)*)
(*k=0;*)
(**)
(*\[CapitalXi]points = {\[GothicCapitalX]0};*)
(*\[CapitalXi]norms={normGradF@\[GothicCapitalX]0};*)
(*\[CapitalXi]values={f@\[GothicCapitalX]0};*)
(*plotToPoint = 1;*)
(**)
(*(* 1 - Nonlinear conjugate gradient method *)*)
(*\[Gamma]func1:=Norm[\[CapitalXi]\[Omega][[k]]]^2/\[CapitalXi]p[[k-1]].\[CapitalXi]\[Omega][[k-1]];*)
(*(* 2 - Fletcher\[Dash]Reeves method *)*)
(*\[Gamma]func2:=Norm[\[CapitalXi]\[Omega][[k]]]^2/Norm[\[CapitalXi]\[Omega][[k-1]]]^2;*)
(*(* 3 - Polak\[Dash]Ribi\[EGrave]re method *)*)
(*\[Gamma]func3:=(\[CapitalXi]\[Omega][[k]]-\[CapitalXi]\[Omega][[k-1]]).\[CapitalXi]\[Omega][[k]]/Norm[\[CapitalXi]\[Omega][[k-1]]]^2;*)
(*(* 4 - Nonlinear conjugate gradient method with Hessian matrix *)*)
(*H[{x_,y_}]:=D[f@{x1,x2},{{x1,x2},2}]/.{x1->x,x2->y};*)
(*\[Gamma]func4:=-((H@\[CapitalXi]\[GothicCapitalX][[k-1]] \[CapitalXi]p[[k-1]]).\[CapitalXi]\[Omega][[k]]/(H@\[CapitalXi]\[GothicCapitalX][[k-1]] \[CapitalXi]p[[k-1]]).\[CapitalXi]p[[k-1]]);*)
(**)
(*\[Gamma]func:={\[Gamma]func1,\[Gamma]func2,\[Gamma]func3,\[Gamma]func4}[[method]];*)
(**)
(*(* Plot with residual norms ||w^k||, changes dynamically *)*)
(*Framed@Framed@"Residual plot"*)
(*Dynamic@ListLogPlot[EPS+\[CapitalXi]norms[[1;;plotToPoint]],*)
(*AxesLabel->{"Point k+1", "||\!\(\*SuperscriptBox[\(w\), \(k + 1\)]\)||"},*)
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
(*(* Minimization *)*)
(*MethodDivergedError=False;*)
(*(* 1-st iteration *)*)
(*k=1;*)
(**)
(*\[CapitalXi]\[Omega]~AppendTo~antiGradF@\[GothicCapitalX]0;*)
(*\[CapitalXi]p~AppendTo~\[CapitalXi]\[Omega][[k]];*)
(*\[CapitalXi]\[Aleph]~AppendTo~NArgMin[f[\[GothicCapitalX]0+\[Kappa] \[CapitalXi]\[Omega][[k]]],\[Kappa]];*)
(**)
(*\[CapitalXi]\[GothicCapitalX]~AppendTo~(\[GothicCapitalX]0+\[CapitalXi]\[Aleph][[k]]\[CapitalXi]p[[k]]);*)
(*\[CapitalXi]points~AppendTo~Last@\[CapitalXi]\[GothicCapitalX];*)
(*\[CapitalXi]values~AppendTo~f@Last@\[CapitalXi]\[GothicCapitalX];*)
(*\[CapitalXi]norms~AppendTo~normGradF@Last@\[CapitalXi]\[GothicCapitalX];*)
(*plotToPoint=k+1;*)
(**)
(*(* Following iterations *)*)
(*While[Last@\[CapitalXi]norms>=\[CurlyEpsilon],*)
(*k++;*)
(**)
(*\[CapitalXi]\[Omega]~AppendTo~antiGradF@\[CapitalXi]\[GothicCapitalX][[k-1]];*)
(*(* \[CapitalXi]\[Gamma]\[LeftDoubleBracket]k-1\[RightDoubleBracket] *)*)
(*\[CapitalXi]\[Gamma]~AppendTo~\[Gamma]func;*)
(*\[CapitalXi]p~AppendTo~(\[CapitalXi]\[Gamma][[k-1]]\[CapitalXi]p[[k-1]]+\[CapitalXi]\[Omega][[k]]);*)
(*\[CapitalXi]\[Aleph]~AppendTo~NArgMin[f[\[CapitalXi]\[GothicCapitalX][[k-1]]+\[Kappa] \[CapitalXi]p[[k]]],\[Kappa]];*)
(**)
(*\[CapitalXi]\[GothicCapitalX]~AppendTo~(\[CapitalXi]\[GothicCapitalX][[k-1]]+\[CapitalXi]\[Aleph][[k]]\[CapitalXi]p[[k]]);*)
(*\[CapitalXi]points~AppendTo~Last@\[CapitalXi]\[GothicCapitalX];*)
(*\[CapitalXi]values~AppendTo~f@Last@\[CapitalXi]\[GothicCapitalX];*)
(*\[CapitalXi]norms~AppendTo~normGradF@Last@\[CapitalXi]\[GothicCapitalX];*)
(*plotToPoint=k+1;*)
(**)
(*If[k>maxIterations,Print@"ERROR: MAX NUMBER OF ITERATIONS EXCEEDED";Abort[]];*)
(*If[Norm[Last@\[CapitalXi]\[GothicCapitalX]-\[GothicCapitalX]0]>10^5,Print@"ERROR: METHOD DIVERGES";MethodDivergedError=True;Abort[]];*)
(*];*)
(**)
(*(* Dislay the result *)*)
(*\[GothicCapitalX]=N@Last@\[CapitalXi]points;*)
(*Column@{*)
(*Dynamic@Row@{"Display until iteration: ", plotToPoint-1},*)
(*Slider[Dynamic@plotToPoint,{1,Length@\[CapitalXi]points,1}]*)
(*}*)
(*Row@{"Argmin: \[GothicCapitalX] = ",\[GothicCapitalX]}*)
(*Row@{"Number of iterations: K = ", k}*)
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
(*contourToPoint = Length@\[CapitalXi]\[Aleph];*)
(*Dynamic@ContourPlot[Log10[zOffset+f@{x,y}],{x,center[[1]]-areaSize/zoom,center[[1]]+areaSize/zoom},{y,center[[2]]-areaSize/zoom,center[[2]]+areaSize/zoom},*)
(*ColorFunction->Function[{z},Hue[.65(1-z)]],*)
(*Contours->30,*)
(*ContourStyle->Black,*)
(*ImageSize->400,*)
(*(* display the process *)*)
(*Epilog->{Black,Thickness@0.002,Dynamic@Table[Arrow@\[CapitalXi]points[[i-1;;i]],{i,2,contourToPoint}],Red,PointSize@0.015,Dynamic@Point@\[CapitalXi]points[[1;;contourToPoint]],PointSize@0.02,Point@Last@\[CapitalXi]points}*)
(*]*)
(*Column@{*)
(*Dynamic@Row@{"Displayed iterations: ",contourToPoint-1},*)
(*Slider[Dynamic@contourToPoint,{1,Length@\[CapitalXi]points,1}],*)
(*Dynamic@Row@{"Zoom: ",zoom},*)
(*Slider[Dynamic@zoom,{1,20,0.01}]*)
(*}*)

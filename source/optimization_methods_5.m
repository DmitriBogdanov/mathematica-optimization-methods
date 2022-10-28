(* ::Package:: *)

(* ::Input:: *)
(*EPS=10^-18;*)
(*(* Rosenbrock function *)*)
(*\[Alpha]=25;*)
(*rosenbrock[{x_,y_}]:=\[Alpha] (x^2-y)^2+(x-1)^2;*)
(**)
(*(* Quadratic function *)*)
(*func3[{x_,y_}]:=5x^2+2y^2+4x y + 4Sqrt[5](x+y)-14;*)
(**)
(*(* Function selection *)*)
(*f=rosenbrock;*)
(*(* Method selection *)*)
(*(* 1 - Davidon-Fletcher-Powell method *)*)
(*(* 2 - Broyden-Fletcher-Goldfarb-Shanno method *)*)
(*(* 3 - Powell method *)*)
(*(* 4 - McCormick method *)*)
(*method=3;*)
(*(* Max iterations allowed before calling Abort[] *)*)
(*maxIterations=1000;*)
(*(* Precision *)*)
(*\[CurlyEpsilon]=10^-3;*)
(*(* Starting point *)*)
(*\[GothicCapitalX]0={-1,-2};*)
(**)
(*Framed@Framed@"Function"*)
(*Row@{"f(x, y) = ",TraditionalForm@f[{x,y}]}*)
(*Framed@Framed@"Method"*)
(*methodNames={"Davidon-Fletcher-Powell method","Broyden-Fletcher-Goldfarb-Shanno method", "Powell method","McCormick method"};*)
(*Print@methodNames[[method]];*)
(**)
(*(* Helper functions *)*)
(*antiGradF[{x_,y_}]:=-Grad[f@{x1,x2},{x1,x2}]/.{x1->x,x2->y};*)
(*normGradF[{x_,y_}]:=Norm@antiGradF@{x,y};*)
(*hessian[{x_,y_}]:=D[f@{x1,x2},{{x1,x2},2}]/.{x1->x,x2->y};*)
(**)
(*(* Init variables *)*)
(*\[CapitalXi]points = {\[GothicCapitalX]0};*)
(*\[CapitalXi]norms={normGradF@\[GothicCapitalX]0};*)
(*\[CapitalXi]values={f@\[GothicCapitalX]0};*)
(*restart=False;*)
(*plotToPoint = 1;*)
(*MethodDivergedError=False;*)
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
(*(* ######################################## *)*)
(*(* ##### Davidon-Fletcher-Powell method ##### *)*)
(*(* ######################################## *)*)
(*MethodDFP:=Module[{X=\[GothicCapitalX]0,\[Kappa]=1,A=IdentityMatrix@2,P,\[CapitalDelta]X,\[CapitalDelta]\[Omega],\[CapitalDelta]A,\[CapitalXi]\[Omega],\[CapitalXi]\[Kappa]},*)
(*\[CapitalXi]\[Omega]={antiGradF@X};*)
(*\[CapitalXi]\[Kappa]={\[Kappa]};*)
(**)
(*k = 0;*)
(*plotToPoint=k+1;*)
(**)
(*P=\[CapitalXi]\[Omega][[1]];*)
(**)
(*While[\[CapitalXi]norms[[-1]]>=\[CurlyEpsilon],*)
(*k++;*)
(**)
(*\[CapitalXi]\[Kappa]~AppendTo~NArgMin[f[X+\[Kappa]\[Kappa] P], \[Kappa]\[Kappa]];*)
(*\[CapitalDelta]X=\[CapitalXi]\[Kappa][[-1]] P;*)
(*X+=\[CapitalDelta]X;*)
(*\[CapitalXi]\[Omega]=Append[\[CapitalXi]\[Omega],antiGradF[X]];*)
(*\[CapitalDelta]\[Omega]=\[CapitalXi]\[Omega][[-1]]-\[CapitalXi]\[Omega][[-2]];*)
(**)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]values~AppendTo~f@X;*)
(*\[CapitalXi]norms~AppendTo~Norm@\[CapitalXi]\[Omega][[-1]];*)
(*plotToPoint=k+1;*)
(**)
(*\[CapitalDelta]A=-(KroneckerProduct[\[CapitalDelta]X,\[CapitalDelta]X]/\[CapitalDelta]\[Omega].\[CapitalDelta]X)-KroneckerProduct[A.\[CapitalDelta]\[Omega],A.\[CapitalDelta]\[Omega]]/(A.\[CapitalDelta]\[Omega]).\[CapitalDelta]\[Omega];*)
(*A+=\[CapitalDelta]A;*)
(*P=A.\[CapitalXi]\[Omega][[-1]];*)
(**)
(*If[k>maxIterations,Print@"ERROR: MAX NUMBER OF ITERATIONS EXCEEDED";Abort[]];*)
(*If[Norm[X-\[GothicCapitalX]0]>10^5,Print@"ERROR: METHOD DIVERGES";MethodDivergedError=True;Abort[]];*)
(*];*)
(*];*)
(**)
(*(* ################################################ *)*)
(*(* ##### Broyden-Fletcher-Goldfarb-Shanno method ##### *)*)
(*(* ################################################ *)*)
(*MethodBPGS:=Module[{X=\[GothicCapitalX]0,\[Kappa]=1,A=IdentityMatrix@2,P,\[CapitalDelta]X,\[CapitalDelta]\[Omega],r,\[CapitalDelta]A,\[CapitalXi]\[Omega],\[CapitalXi]\[Kappa]},*)
(*\[CapitalXi]\[Omega]={antiGradF@X};*)
(*\[CapitalXi]\[Kappa]={\[Kappa]};*)
(**)
(*k = 0;*)
(*plotToPoint=k+1;*)
(**)
(*P=\[CapitalXi]\[Omega][[1]];*)
(**)
(*While[Last@\[CapitalXi]norms>=\[CurlyEpsilon],*)
(*k++;*)
(**)
(*\[CapitalXi]\[Kappa]~AppendTo~NArgMin[f[X+\[Kappa]\[Kappa] P],\[Kappa]\[Kappa]];*)
(*\[CapitalDelta]X=\[CapitalXi]\[Kappa][[-1]] P;*)
(*X+=\[CapitalDelta]X;*)
(*\[CapitalXi]\[Omega]=Append[\[CapitalXi]\[Omega],antiGradF[X]];*)
(*\[CapitalDelta]\[Omega]=\[CapitalXi]\[Omega][[-1]]-\[CapitalXi]\[Omega][[-2]];*)
(**)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]values~AppendTo~f@X;*)
(*\[CapitalXi]norms~AppendTo~Norm@\[CapitalXi]\[Omega][[-1]];*)
(*plotToPoint=k+1;*)
(**)
(*r=A.\[CapitalDelta]\[Omega]/(A.\[CapitalDelta]\[Omega]).\[CapitalDelta]\[Omega]-\[CapitalDelta]X/\[CapitalDelta]\[Omega].\[CapitalDelta]X;*)
(*\[CapitalDelta]A=-(KroneckerProduct[\[CapitalDelta]X,\[CapitalDelta]X]/\[CapitalDelta]\[Omega].\[CapitalDelta]X)-KroneckerProduct[A.\[CapitalDelta]\[Omega],A.\[CapitalDelta]\[Omega]]/(A.\[CapitalDelta]\[Omega]).\[CapitalDelta]\[Omega]+((A.\[CapitalDelta]\[Omega]).\[CapitalDelta]\[Omega])KroneckerProduct[r,r];*)
(*A+=\[CapitalDelta]A;*)
(**)
(*P=A.\[CapitalXi]\[Omega][[-1]];*)
(**)
(*If[k>maxIterations,Print@"ERROR: MAX NUMBER OF ITERATIONS EXCEEDED";Abort[]];*)
(*If[Norm[X-\[GothicCapitalX]0]>10^5,Print@"ERROR: METHOD DIVERGES";MethodDivergedError=True;Abort[]];*)
(*];*)
(*];*)
(**)
(*(* ######################## *)*)
(*(* ##### Powell method ##### *)*)
(*(* ######################## *)*)
(*MethodPowell:=Module[{X=\[GothicCapitalX]0,\[Kappa]=1,A=IdentityMatrix@2,P,\[CapitalDelta]X,\[CapitalDelta]\[Omega],\[CapitalDelta]Xt,\[CapitalDelta]A,\[CapitalXi]\[Omega],\[CapitalXi]\[Kappa]},*)
(*\[CapitalXi]\[Omega]={antiGradF@X};*)
(*\[CapitalXi]\[Kappa]={\[Kappa]};*)
(**)
(*k=0;*)
(*plotToPoint=k+1;*)
(**)
(*P=\[CapitalXi]\[Omega][[1]];*)
(**)
(*While[Last@\[CapitalXi]norms>=\[CurlyEpsilon],*)
(*k++;*)
(**)
(*\[CapitalXi]\[Kappa]~AppendTo~NArgMin[f[X + \[Kappa]\[Kappa] P], \[Kappa]\[Kappa]];*)
(*\[CapitalDelta]X=\[CapitalXi]\[Kappa][[-1]] P;*)
(*X+=\[CapitalDelta]X;*)
(*\[CapitalXi]\[Omega]~AppendTo~antiGradF@X;*)
(*\[CapitalDelta]\[Omega]=\[CapitalXi]\[Omega][[-1]]-\[CapitalXi]\[Omega][[-2]];*)
(**)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]values~AppendTo~f@X;*)
(*\[CapitalXi]norms~AppendTo~Norm@\[CapitalXi]\[Omega][[-1]];*)
(*plotToPoint=k+1;*)
(**)
(*\[CapitalDelta]Xt=\[CapitalDelta]X+A.\[CapitalDelta]\[Omega];*)
(*\[CapitalDelta]A=-(KroneckerProduct[\[CapitalDelta]Xt,\[CapitalDelta]Xt]/\[CapitalDelta]\[Omega].\[CapitalDelta]Xt);*)
(*A+=\[CapitalDelta]A;*)
(*P=A.\[CapitalXi]\[Omega][[-1]];*)
(**)
(*If[k>maxIterations,Print@"ERROR: MAX NUMBER OF ITERATIONS EXCEEDED";Abort[]];*)
(*If[Norm[X-\[GothicCapitalX]0]>10^5,Print@"ERROR: METHOD DIVERGES";MethodDivergedError=True;Abort[]];*)
(*];*)
(*];*)
(**)
(*(* ########################### *)*)
(*(* ##### McCormick method ##### *)*)
(*(* ########################### *)*)
(*MethodMcCormick:=Module[{X=\[GothicCapitalX]0,\[Kappa]=1,A=IdentityMatrix@2,P,\[CapitalDelta]X,\[CapitalDelta]\[Omega],\[CapitalDelta]A,\[CapitalXi]\[Omega],\[CapitalXi]\[Kappa]},*)
(*$MaxExtraPrecision=1000;*)
(**)
(*\[CapitalXi]\[Omega]={antiGradF@X};*)
(*\[CapitalXi]\[Kappa]={\[Kappa]};*)
(**)
(*k=0;*)
(*plotToPoint=k+1;*)
(**)
(*P=\[CapitalXi]\[Omega][[1]];*)
(**)
(*While[Last@\[CapitalXi]norms>=\[CurlyEpsilon],*)
(*k++;*)
(**)
(*\[CapitalXi]\[Kappa]~AppendTo~NArgMin[f[X+\[Kappa]\[Kappa] P],\[Kappa]\[Kappa]];*)
(*\[CapitalDelta]X=\[CapitalXi]\[Kappa][[-1]] P;*)
(*X+=\[CapitalDelta]X;*)
(*\[CapitalXi]\[Omega]~AppendTo~antiGradF@X;*)
(*\[CapitalDelta]\[Omega]=\[CapitalXi]\[Omega][[-1]]-\[CapitalXi]\[Omega][[-2]];*)
(**)
(*\[CapitalXi]points~AppendTo~X;*)
(*\[CapitalXi]values~AppendTo~f@X;*)
(*\[CapitalXi]norms~AppendTo~Norm@\[CapitalXi]\[Omega][[-1]];*)
(*plotToPoint=k+1;*)
(**)
(*If[\[CapitalDelta]\[Omega].\[CapitalDelta]X==0,Print@"ERROR: DIVISION BY ZERO IN MCCORMICK METHOD";Abort[]];*)
(**)
(*\[CapitalDelta]A=-(KroneckerProduct[\[CapitalDelta]X,\[CapitalDelta]X]/\[CapitalDelta]\[Omega].\[CapitalDelta]X)+KroneckerProduct[A.\[CapitalDelta]\[Omega],\[CapitalDelta]X]/\[CapitalDelta]X.\[CapitalDelta]\[Omega];*)
(*A+=\[CapitalDelta]A;*)
(*P=A.\[CapitalXi]\[Omega][[-1]];*)
(**)
(*(* \:0420\:0435\:0441\:0442\:0430\:0440\:0442 *)*)
(*If[k~Mod~10==0,A=IdentityMatrix@2;P=\[CapitalXi]\[Omega][[-1]];];*)
(**)
(*If[k>maxIterations,Print@"ERROR: MAX NUMBER OF ITERATIONS EXCEEDED";Abort[]];*)
(*If[Norm[X-\[GothicCapitalX]0]>10^5,Print@"ERROR: METHOD DIVERGES";MethodDivergedError=True;Abort[]];*)
(*];*)
(*];*)
(**)
(*(* Launch selected method *)*)
(*If[method==1,MethodDFP];*)
(*If[method==2,MethodBPGS];*)
(*If[method==3,MethodPowell];*)
(*If[method==4,MethodMcCormick];*)
(**)
(*(* Dislay the result *)*)
(*\[GothicCapitalX]=N@Last@\[CapitalXi]points;*)
(*Column@{*)
(*Dynamic@Row@{"Display until iteration: ", plotToPoint-1},*)
(*Slider[Dynamic@plotToPoint,{1,Length@\[CapitalXi]points,1}]*)
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
(*Epilog->{Black,Thickness@0.002,Dynamic@Table[Arrow@\[CapitalXi]points[[i-1;;i]],{i,2,contourToPoint}],Red,PointSize@0.015,Dynamic@Point@\[CapitalXi]points[[1;;contourToPoint]],PointSize@0.02,Point@Last@\[CapitalXi]points}*)
(*]*)
(*Column@{*)
(*Dynamic@Row@{"Displayed iterations: ",contourToPoint-1},*)
(*Slider[Dynamic@contourToPoint,{1,Length@\[CapitalXi]points,1}],*)
(*Dynamic@Row@{"Zoom: ",zoom},*)
(*Slider[Dynamic@zoom,{1,20,0.01}]*)
(*}*)

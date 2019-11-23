getSelectionCoordinates(x, y);
//X0 and Y0 :the center of the polygon
X0 = (x[0] + x[lengthOf(x)/2])/2 ;
Y0 = (y[0] + y[lengthOf(y)/2])/2 ;


//Length of X0 to X1
X1 = x[0];
Y1 = y[0];
v_X1 = X1 - X0;
v_Y1 = (Y1 - Y0)*-1;
L_v1 = sqrt(v_X1*v_X1 + v_Y1*v_Y1 );

//Vector inner product v_X1 and v_(1,0)
v_Xx = 1 ;
v_Yx = 0 ;
L_vx = sqrt(1) ;

a = (( v_X1* v_Xx)+( v_Y1*v_Yx) )/ ((L_v1)*(L_vx));
theta = acos(a) * 180 / PI;

L = L_v1;
//run("Enlarge...", "enlarge=1");
run("Copy");
newImage("basic", "RGB black", 2*L, 2*L, 1);
run("Paste");
run("Select None");
if (Y1 > Y0){theta *= -1 ;}
run("Rotate... ", "angle="+ theta +" grid=1 interpolation=Bilinear");



//new

X0 = getWidth()/2;
Y0 = getHeight()/2;

v_X1 = L ;
v_Y1 = 0 ;

nPolygon = lengthOf(x);
xArray=newArray();
yArray=newArray();
for (i = 0; i < nPolygon ; i++) {
	Radian = (360/nPolygon) * (PI/180) * (i+1) ;
	v_Xn = v_X1 * cos(Radian) - v_Y1 * sin(Radian);
	v_Yn = v_X1 * sin(Radian) + v_Y1 * cos(Radian);

	Xn = round(X0 + v_Xn); 
	Yn = round(Y0 + v_Yn*(-1)); 
	
	xArray = Array.concat(xArray, Xn );
	yArray = Array.concat(yArray, Yn );		
}
makeSelection('polygon', xArray, yArray);
run("Copy");

//

radians = (360/nPolygon)/2 *(PI/180);
//print( 1/cos(radians) );
newW = (L/cos(radians))*2 ;
newH = newW;
newImage("brick", "RGB white", newW, newH, 1);

//copy basic ,paste to brick
setForegroundColor(0, 0, 0);
run("Select All");
run("Fill", "slice");
run("Select None");

newRadius = 2*L;

run("Canvas Size...", "width=" + 4*L +  " height=" + 4*L +" position=Center zero");	
run("Rotate... ", "angle="+ (360/nPolygon)/2 +" grid=1 interpolation=Bilinear");
for (i = 0; i < nPolygon; i++) {
	run("Canvas Size...", "width="+ 4*L + 2*L  +" height="+ 4*L +" position=Center-Left zero");
	run("Paste");
	run("Select None");
	run("Canvas Size...", "width="+ 4*L +" height="+ 4*L +" position=Center-Left zero");	
	run("Rotate... ", "angle="+ (360/nPolygon) +" grid=1 interpolation=Bilinear");
}

close("basic*");




//get outsid box to Fill outsid color
X0 = getWidth()/2;
Y0 = getHeight()/2;

v_X1 = 2*L ;
v_Y1 = 0 ;

nPolygon = lengthOf(x);
xArray=newArray();
yArray=newArray();
for (i = 0; i < nPolygon ; i++) {
	Radian = (360/nPolygon) * (PI/180) * (i+1) ;
	v_Xn = v_X1 * cos(Radian) - v_Y1 * sin(Radian);
	v_Yn = v_X1 * sin(Radian) + v_Y1 * cos(Radian);

	Xn = round(X0 + v_Xn); 
	Yn = round(Y0 + v_Yn*(-1)); 
	
	xArray = Array.concat(xArray, Xn );
	yArray = Array.concat(yArray, Yn );		
}
makeSelection('polygon', xArray, yArray);
run("Make Inverse");
//Background Color
setForegroundColor(200, 200, 185);
run("Fill", "slice");
run("Select None");
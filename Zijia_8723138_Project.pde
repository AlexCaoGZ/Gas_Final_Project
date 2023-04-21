/*
FILE:         Zijia_8723138_Project
PROJECT:      SENG3040 - Graphics, Animation and Sound
PROGRAMMER:   Zijia Cao
DESCRIPTION:
  The functions in this file are used to solar system
*/
import java.util.ArrayList;
import java.util.List;

    final int PAUSE = 0;
    final int RESET = 1;
    final int SCREENSHOT = 2;

    List<planets> planetList = new ArrayList<>();
    List<stars> starList = new ArrayList<>();
    bars barEDFS;
    bars barERS1;
    bars barERS2;
    bars barMDFE;
    bars barMRS;
    buttons pauseBtn;
    buttons resetBtn;
    buttons screenshotBtn;
    //GButton btn;
    //GTextArea txa;
    
    /*
    FUNCTION:    setup
    DESCRIPTION: This function will setup the background.
    PARAMETERS:
      none
    RETURNS:
      void
    */
    public void setup(){
        size(700, 700);
        //can not set g4p up
        //btn = new GButton(this, -200, 250, 90, 30, "Submit");
        //txa = new GTextArea(this, -330, 250, 110, 30);

        pauseBtn = new buttons(PAUSE,360,580,40,"Pause");
        resetBtn = new buttons(RESET,500,580,40,"Reset");
        screenshotBtn = new buttons(SCREENSHOT,640,580,40,"Screen Shot");

        barEDFS = new bars(80,680,100,8);
        barERS1 = new bars(220,680,100,8);
        barERS2 = new bars(360,680,100,8);
        barMDFE = new bars(500,680,100,8);
        barMRS = new bars(640,680,100,8);

        sun Sun = new sun(0,150,150,0,0,"src/sun.png");
        planets Mercury = new planets(70,8,8,0.06,0.01,"src/mercury.png");
        planets Venus = new planets(100,12,12,0.05,0.01,"src/venus.png");
        planets Earth = new planets(150,26,26,0.04,0.01,"src/earth.png");
        satellites Moon = new satellites(20,6,6,0.01,0.01,"src/moon.png");
        Earth.satelliteList = new ArrayList<>();
        Earth.satelliteList.add(Moon);
        planets Mars = new planets(200,23,23,0.03,0.01,"src/mars.png");
        satellites Phobos = new satellites( 16,5,5,0.02,0.01,"src/moon.png");
        satellites Deimos = new satellites( 20,4,4,0.01,0.01,"src/moon.png");
        Mars.satelliteList = new ArrayList<>();
        Mars.satelliteList.add(Phobos);
        Mars.satelliteList.add(Deimos);
        planets Jupiter = new planets(280,70,70,0.02,0.01,"src/jupiter.png");
        planets Saturn = new planets(370,90,90,0.01,0.01,"src/saturn.png");
        //Jupiter have 79 satellites, and Saturn have 82 satellites
        //And we should have Uranus and Neptune, but the screen size is not big enough.
        //So ... forget about those.

        planetList.add(Sun);
        planetList.add(Mercury);
        planetList.add(Venus);
        planetList.add(Earth);
        planetList.add(Mars);
        planetList.add(Jupiter);
        planetList.add(Saturn);

        //stars
        for (int i = 0; i < 100; i++) {
            float x = random(pixelWidth);
            float y = random(pixelHeight);
            stars star = new stars(x,y);
            starList.add(star);
        }
    }
    
/*
FUNCTION:    draw
DESCRIPTION: This function will draw.
PARAMETERS:
  none
RETURNS:
  void
*/    
    public void draw(){
        background(0,0,0);

        drawStarfield();
        drawControls();
    }
    
/*
FUNCTION:    drawStarfield
DESCRIPTION: This function will draw the Starfield.
PARAMETERS:
  none
RETURNS:
  void
*/        
     public void drawStarfield(){
       
       for (stars star:starList
        ) {
            star.drawStar();
        }

        translate(pixelWidth/2,pixelHeight/2);

        //loop all planets
        for (planets planet:planetList
        ) {
            if(planet.satelliteList == null){
                planet.drawPlanet();
            }
            else{
                planet.drawPlanetWithSatellite();
                //loop all satellites in that planet
                for (satellites satellite:planet.satelliteList
                ) {
                    satellite.drawPlanet();
                }
                popMatrix();
            }
        }
        translate(-pixelWidth/2,-pixelHeight/2);
    }
    
/*
FUNCTION:    drawControls
DESCRIPTION: This function will draw the Controls.
PARAMETERS:
  none
RETURNS:
  void
*/     
    public void drawControls(){
        text("Pause",360,575);
        text("Reset",500,575);
        text("ScreenShot",640,575);

        text("Earth's Distance From Sun",30,650);
        text("Earth's Rotation Speed",170,650);
        text("Earth's Revolving Speed",310,650);
        text("Moon's Distance From Earth",450,650);
        text("Moon's Rotation Speed",590,650);
        barEDFS.drawBar();
        planetList.get(3).distantFormSun = (int)(barEDFS.ratio * 300);
        barERS1.drawBar();
        planetList.get(3).speedOfPlanetRotations = (barERS1.ratio * 0.06);
        barERS2.drawBar();
        planetList.get(3).speedOfPlanetRevolving = (barERS2.ratio * 0.06);
        barMDFE.drawBar();
        planetList.get(3).satelliteList.get(0).distantFormSun = (int)(barMDFE.ratio * 40);
        barMRS.drawBar();
        planetList.get(3).satelliteList.get(0).speedOfPlanetRotations = (barMRS.ratio * 0.06);

        stroke(130);

        

        pauseBtn.drawButton();
        resetBtn.drawButton();
        screenshotBtn.drawButton();
    }

/*
FUNCTION:    mousePressed
DESCRIPTION: This function will handle the user click his mouse.
PARAMETERS:
  none
RETURNS:
  void
*/
    public void mousePressed(){
        barEDFS.mousePressed();
        barERS1.mousePressed();
        barERS2.mousePressed();
        barMDFE.mousePressed();
        barMRS.mousePressed();

        pauseBtn.mousePressed();
        resetBtn.mousePressed();
        screenshotBtn.mousePressed();
    }

/*
FUNCTION:    mouseDragged
DESCRIPTION: This function will handle the user Drag his mouse/
PARAMETERS:
  none
RETURNS:
  void
*/
    public void mouseDragged(){
        barEDFS.mouseDragged();
        barERS1.mouseDragged();
        barERS2.mouseDragged();
        barMDFE.mouseDragged();
        barMRS.mouseDragged();
    }

/*
FUNCTION:    mouseReleased
DESCRIPTION: This function will handle the user release his mouse/
PARAMETERS:
  none
RETURNS:
  void
*/
    public void mouseReleased(){
        barEDFS.mouseReleased();
        barERS1.mouseReleased();
        barERS2.mouseReleased();
        barMDFE.mouseReleased();
        barMRS.mouseReleased();

        screenshotBtn.mouseReleased();
        resetBtn.mouseReleased();
        pauseBtn.mouseReleased();
    }
    
    /*
     * NAME     : planets
     * PURPOSE  : the class for build a planet.
     */
    class planets{
        int distantFormSun;
        int sizeX,sizeY;
        double speedOfPlanetRotations;
        float planetRotations = 0;
        double speedOfPlanetRevolving;
        float planetRevolving = 0;
        PImage imgOfPlanet;
        List<satellites> satelliteList;
        boolean isPause = false;

        planets(int distantFormSun,int sizeX, int sizeY, double speedOfPlanetRotations,double speedOfPlanetRevolving, String nameOfImg){
            this.distantFormSun = distantFormSun;
            this.sizeX = sizeX;
            this.sizeY = sizeY;
            this.speedOfPlanetRotations = (float) speedOfPlanetRotations;
            this.speedOfPlanetRevolving = (float)speedOfPlanetRevolving;
            this.imgOfPlanet = loadImage(nameOfImg);
        }

        void drawPlanet(){
            pushMatrix();
            rotate(planetRotations);
            translate(distantFormSun,0);
            rotate(planetRevolving);
            imageMode(CENTER);
            image(imgOfPlanet,0,0,sizeX,sizeY);
            popMatrix();

            if(isPause){

            }
            else{
                planetRotations += speedOfPlanetRotations;
                planetRevolving += speedOfPlanetRevolving;
            }
        }

        void drawPlanetWithSatellite(){
            pushMatrix();
            rotate(planetRotations);
            translate(distantFormSun,0);
            rotate(planetRevolving);
            imageMode(CENTER);
            image(imgOfPlanet,0,0,sizeX,sizeY);

            if(isPause){

            }
            else{
                planetRotations += speedOfPlanetRotations;
                planetRevolving += speedOfPlanetRevolving;
            }
        }
    }
    
    /*
     * NAME     : sun extends planets
     * PURPOSE  : the class for build a sun.
     */
    class sun extends planets{

        sun(int distantFormSun, int sizeX, int sizeY, double speedOfPlanetRotations, double speedOfPlanetRevolving, String nameOfImg) {
            super(distantFormSun, sizeX, sizeY, speedOfPlanetRotations, speedOfPlanetRevolving, nameOfImg);
        }

        void drawPlanet(){
            translate(distantFormSun,0);
            imageMode(CENTER);
            image(imgOfPlanet,0,0,sizeX,sizeY);
            filter(BLUR);
        }
    }

    /*
     * NAME     : satellites extends planets
     * PURPOSE  : the class for build a satellites.
     */
    class satellites extends planets{

        satellites(int orbitAltitude, int sizeX, int sizeY, double speedOfPlanetRotations, double speedOfPlanetRevolving, String nameOfImg) {
            super(orbitAltitude, sizeX, sizeY, speedOfPlanetRotations, speedOfPlanetRevolving, nameOfImg);
        }

    }

    /*
     * NAME     : stars
     * PURPOSE  : the class for build a stars.
     */
    class stars{
        float x,y;
        stars(float x, float y){
            this.x = x;
            this.y = y;
        }

        void drawStar(){
          noStroke();
          fill(255,255,255);
          ellipse(x,y,3,3);
          fill(130);
          strokeWeight(3);
        }
    }

    /*
     * NAME     : bars
     * PURPOSE  : the class for build the bar
     */
    class bars {
        boolean isDrag, isActive;
        float startX,endX;
        float x,y,w,r;
        float circleX;
        float ratio;

        bars(float x, float y, float w, float r){
            this.x=x;
            this.y=y;
            this.w=w;
            this.r=r;
            this.circleX = x;
            this.startX = (float)(x - w/2);
            this.endX =(float)(x + w/2);
        }

        void drawBar(){
            if(isActive && isDrag){
                this.circleX = (float)mouseX;
                if(circleX > endX){
                    circleX = endX;
                }
                else if(circleX < startX){
                    circleX = startX;
                }
            }

            ratio = (circleX - startX)/w;

            stroke(130);
            strokeWeight(4);
            line(startX,y,endX,y);

            if(isActive){
                fill(255,0,0);
            }
            else{
                fill(130);
            }
            noStroke();
            ellipse(circleX,y,r*2,r*2);
        }

        void mousePressed(){
            if(dist(mouseX,mouseY,circleX,y)<r){
                isActive = true;
            }
            else{
                isActive = false;
            }
        }

        void mouseDragged(){
            isDrag = true;
        }

        void mouseReleased(){
            isDrag = false;
            isActive = false;
        }

    }

    /*
     * NAME     : buttons
     * PURPOSE  : the class for build the buttons
     */
    class buttons{
        float x,y,size;
        String text;
        int id;
        boolean isPressed = false;

        buttons(int id, float x, float y, float size, String text){
            this.id=id;
            this.x=x;
            this.y=y;
            this.size=size;
            this.text=text;
        }

        void drawButton(){
            if(isPressed) {
                fill(255,0,0);
                rect(x,y,size,size);
                fill(130);
                switch (id) {
                    case PAUSE:
                        for (planets planet : planetList
                        ) {
                            planet.isPause ^= true;
                            if(planet.satelliteList!=null){
                                for (satellites satellite:planet.satelliteList
                                ) {
                                    satellite.isPause ^= true;
                                }
                            }
                        }
                        break;
                    case RESET:
                        for (planets planet : planetList
                        ) {
                            planet.planetRotations = 0;
                        }
                        break;
                    case SCREENSHOT:
                        saveFrame("screanShot.png");
                        break;
                }
            }
            else{
                rect(x,y,size,size);
                fill(130);
            }
        }

        void mousePressed(){
            if(dist(mouseX,mouseY,x,y)<size){
                isPressed = true;
            }
        }

        void mouseReleased(){
            isPressed = false;
        }
    }

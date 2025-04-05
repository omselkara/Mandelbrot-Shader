#version 460 core
out vec4 gl_FragColor;

uniform vec2 resolution;

uniform int n;
uniform float treshold;

uniform vec2 topLeft;
uniform vec2 bottomRight;

struct Complex{
    float real;
    float imaginary;
};

Complex multiply(Complex c1,Complex c2){
    Complex result;
    result.real = c1.real*c2.real-c1.imaginary*c2.imaginary;
    result.imaginary = c1.real*c2.imaginary+c1.imaginary*c2.real;
    return result;
}

Complex add(Complex c1,Complex c2){
    Complex result;
    result.real = c1.real+c2.real;
    result.imaginary = c1.imaginary+c2.imaginary;
    return result;
}

float length(Complex c){
    return sqrt(c.real*c.real+c.imaginary*c.imaginary);
}

bool fractal(Complex c){
    Complex z;
    z.real = 0;
    z.imaginary = 0;
    for (int i=1;i<n;i++){
        Complex zSquare = multiply(z,z);
        z = add(zSquare,c);
        if (length(z)>treshold){
            return false;
        }
    }
    return true;
}

void main(){
    vec2 pos = gl_FragCoord.xy/resolution;
    Complex c;
    c.real = topLeft.x+(bottomRight.x-topLeft.x)*pos.x;
    c.imaginary = topLeft.y+(bottomRight.y-topLeft.y)*pos.y;
    if (fractal(c)){
        gl_FragColor = vec4(vec3(0.0),1.0);
    }
    else{
        gl_FragColor = vec4(pos,0.0,1.0);
    }
    
}
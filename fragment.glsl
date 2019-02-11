varying vec4 position;
varying vec3 normal;
varying vec3 light_direction;

void main()
{
  vec4 ambient = vec4(1, 0, 0, 1);
  vec4 diffuse = vec4(0, 1, 0, 1);
  vec4 specular = vec4(0, 0, 1, 1);
  vec4 n(normal[0], normal[1], normal[2], 0);
  vec4 color = vec4(0,0,0,0);
  
  for(uint i = 0; i < gl_MaxLights; i++){
    vec4 l(light_direction[0], light_direction[1]. light_direction[2], 1);
    
    //Ambient
    ambient = gl_LightSource(i).ambient*gl_FrontMaterial.ambient;
    
    //Diffuse
    diffuse = gl_LightSource(i).diffuse*gl_FrontMaterial.diffuse*max(dot(normalize(l), n), 0.0);
    
    //Specular
    vec4 r = -1.0*l+2.0*(dot(l, n)*n);
    specular = gl_LightSource(i).specular*gl_FrontMaterial.specular*pow(max(dot(normalize(r),normalize(-position))), gl_FrontMaterial.shiniess);

    color += ambient+diffuse+specular; 
  }
  gl_FragColor = color;
}

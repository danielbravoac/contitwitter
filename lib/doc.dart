int suma(int n1, int n2){
  return n1+n2;
}
int r=suma(1,2);
void saludos({String nombre:"El", String apellido:"pepe"}){
  print ("Hola $nombre $apellido");
}
var i = saludos(nombre: "ivan",apellido:"juajo");
var j = saludos(nombre: "mario",apellido:"juajo");
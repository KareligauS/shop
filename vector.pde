class Vector2 {
  float x;
  float y;
  
  Vector2(){}
  
  Vector2(float _x, float _y) {
    SetCoordinates(_x, _y);
  }
  
  Vector2(Vector2 another) {
    SetCoordinates(another);
  }
  
  Vector2 Rotate(float rotation){
    // cos  | - sin | x
    // sin  |   cos | y
    
    float rad = radians(rotation); 
    Vector2 temp = new Vector2();
    temp.x = cos(rad) * x + -sin(rad) * y;
    temp.y = sin(rad) * x + cos(rad) * y;
    
    return temp;
  }
  
  Vector2 Sum(Vector2 another) {
    return new Vector2(this.x + another.x, this.y + another.y);
  }
  
  Vector2 Substitute(Vector2 another){
    return new Vector2(this.x - another.x, this.y - another.y);
  }
  
  Vector2 DivideBy(float number){
    return new Vector2(this.x / number, this.y / number);
  }

  Vector2 MultiplyBy(float number){
    return new Vector2(this.x * number, this.y * number);
  }
  
  void RotateAndSet(float rotation){
    SetCoordinates(Rotate(rotation));
  }
  
  void SumAndSet(Vector2 another) {
    SetCoordinates(Sum(another));
  }
  
  void SubstituteAndSet(Vector2 another) {
    SetCoordinates(Substitute(another));
  }
  
  void DivideAndSetBy(float number) {
    SetCoordinates(DivideBy(number)); 
  }

  void MultiplyAndSetBy(float number) {
    SetCoordinates(MultiplyBy(number));
  }
  
  void SetCoordinates(Vector2 another){
    this.x = another.x;
    this.y = another.y;
  }
  
  void SetCoordinates(float _x, float _y) {
    x = _x;
    y = _y;
  }
}

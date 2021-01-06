public abstract class IVehicle {
    public virtual void speed(){
        system.debug('Speed of Vehicle is 100');
    }
    public void model(){
        system.debug('Model of vehicle is ME-01');
    }
    // implement abstract method
      public abstract void ModelName();
}
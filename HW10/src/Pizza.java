public class Pizza {

    private int pizza_id;
    private String flavor;
    private String crust;
    private int size;
    private String restaurant;
    private String sauce;
    private double price;
    private int order_id;

    public Pizza(){

    }

    public void setPizza_id(int pizza_id) {
        this.pizza_id = pizza_id;
    }

    public int getPizza_id() {
        return pizza_id;
    }

    public void setFlavor(String flavor) {
        this.flavor = flavor;
    }

    public String getFlavor() {
        return flavor;
    }

    public void setCrust(String crust) {
        this.crust = crust;
    }

    public String getCrust() {
        return crust;
    }

    public void setSize(int size) { this.size = size; }

    public int getSize() {
        return size;
    }

    public void setRestaurant(String restaurant) {
        this.restaurant = restaurant;
    }

    public String getRestaurant() {
        return restaurant;
    }

    public void setSauce(String sauce) {
        this.sauce = sauce;
    }

    public String getSauce() {
        return sauce;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getOrder_id() { return order_id;   }

    public double getPrice(){ return price; }

    public void addToPrice(double price){
        this.price += price;
    }

    public String toString(){
        String s = size + "\" " + crust + " " + flavor + " pizza with " + sauce;
        return s;
    }
}

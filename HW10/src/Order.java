import java.util.ArrayList;

public class Order {

    private int order_id;
    private String customer_name;
    private String restaurant_name;
    private String is_delivery;
    private String car_number;
    private ArrayList<Pizza> pizzas = new ArrayList<>();
    private double orderTotal;

    public Order(){
        order_id = 0;
        customer_name = "null";
        restaurant_name = "null";
        is_delivery = "no";
        car_number = "ABSP42";
    }

    public void setOrder_id(int order_id) { this.order_id = order_id; }

    public int getOrder_id() {
        return order_id;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public String getCustomer_name() {
        return customer_name;
    }


    public void setRestaurant_name(String restaurant_name) {
        this.restaurant_name = restaurant_name;
    }

    public String getRestaurant_name() {
        return restaurant_name;
    }

    public void setIs_delivery(String is_delivery) {
        this.is_delivery = is_delivery;
    }

    public String getIs_delivery() {
        return is_delivery;
    }

    public String getCar_number() {
        return car_number;
    }

    public void setCar_number(String car_number) {
        this.car_number = car_number;
    }

    public void addPizza(Pizza p){ pizzas.add(p); }

    public ArrayList<Pizza> getPizzas(){ return pizzas; }

    public void addToOrderTotal(double price) { this.orderTotal += price; }

    public double getOrderTotal() { return orderTotal; }

    public String toString(){
       String s = "\norder id: " + order_id +
                "\ncustomer_name: " + customer_name +
                "\nrestaurant_name: " + restaurant_name +
                "\nis_delivery: " + is_delivery +
                "\ncar_number: " + car_number;

       return s;
    }
}

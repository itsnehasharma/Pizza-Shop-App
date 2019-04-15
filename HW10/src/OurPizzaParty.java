import java.sql.*;
import java.util.*;

public class OurPizzaParty {

    Connection connection;
    ResultSet rs;
    Statement statement;
    Scanner sc = new Scanner(System.in);

    String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    String LOCAL_HOST = "jdbc:mariadb://localhost:3306/";

    private String database;
    private String username;
    private String password;

    public OurPizzaParty() {
        database = "PizzaParty";
        username = "root";
        password = "ns2998";

    }

    public OurPizzaParty(String database, String username, String password) {
        this.database = database;
        this.username = username;
        this.password = password;
    }

    public boolean openConnection() {
        boolean connected = false;

        try {
            connection = DriverManager.getConnection(LOCAL_HOST + database, username, password);
            System.out.println("Connected to " + database + "!");
            connected = true;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

        return connected;
    }

    public void menu() {

        openConnection();

        int selection = 0;

        while (selection != 3) {
            System.out.println("\n\n***** Main Menu *****");
            System.out.println("[1]  Execute SQL Query");
            System.out.println("[2]  Build an Order");
            System.out.println("[3]  Quit");

            System.out.print("\nEnter choice:\t");
            selection = sc.nextInt();
            sc.nextLine();

            switch (selection) {
                case 1:
                    executeSQLStatement();
                    break;

                case 2:
                    buildOrder();
                    break;

                case 3:
                    System.out.println("Happy eating!");
                    break;

                default:
                    System.out.println("Please choose one of the available options");
            }
        }
    }

    public void executeSQLStatement() {
        try {
            System.out.print("\nEnter SQL Query:\t");
            String query = sc.nextLine();
            statement = connection.createStatement();
            rs = statement.executeQuery(query);

            ResultSetMetaData meta = rs.getMetaData();
            int numCols = meta.getColumnCount();


            System.out.println();
            for (int i = 1; i <= numCols; i++) {
                System.out.print(meta.getColumnName(i));
                if (i != numCols) {
                    System.out.print(", ");
                }
            }
            System.out.println();

            while (rs.next()) {
                for (int i = 1; i <= numCols; i++) {
                    System.out.print(rs.getString(i));
                    if (i != numCols) {
                        System.out.print(", ");
                    }
                }
                System.out.println();
            }

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

    }

    public void buildOrder() { //starts a new order

        Order newOrder = new Order();
        String selectOrders = "select order_id from orders order by order_id;";

        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(selectOrders);
            rs.last();
            int order_id = Integer.parseInt(rs.getString("order_id"));
            newOrder.setOrder_id(order_id + 1);

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

        newOrder.setCustomer_name(getCustomer()); //set name of customer
        getRestaurant(newOrder); //set restaurant name
        isDelivery(newOrder); //set is delivery and car number
        insertOrderIntoDB(newOrder); //insert order into the db
        options(newOrder); //move on to pizza options
    }

    public String getCustomer() {

        System.out.print("\nEnter customer name:\t");
        String customer = sc.next();
        String getCustomer = "SELECT * FROM Customer Where Customer_Name = '" + customer + "';";

        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(getCustomer);

            if (rs.next()) {
                System.out.println("\t* Customer Name: " + rs.getString("Customer_Name"));
                System.out.println("\t* Address: " + rs.getString("Address"));
                System.out.println("\t* Phone Number: " + rs.getString("Phone_Number"));

                System.out.print("Is this you? (yes/no)\t");
                String confirm = sc.next();

                if (confirm.equalsIgnoreCase("yes")) {
                    rs.first();
                    return customer;
                } else if (confirm.equalsIgnoreCase("no")) {
                    System.out.println("Looks like you don't exist. Sorry!");
                    menu();
                } else {
                    System.out.println("Sheesh, follow directions!");
                    menu();
                }

            } else {
                System.out.println("Customer Does Not Exist!");
                getCustomer();
            }

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

        return "null";
    }

    public void getRestaurant(Order o) {

        String getRestaurants = "Select * from Restaurant";
        String restaurant = "";

        System.out.println("\n***** Restaurant Menu *****");

        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(getRestaurants);

            int i = 1;
            while (rs.next()) {
                System.out.println("[" + i + "] " + rs.getString("Restaurant_Name"));
                i++;
            }

            System.out.print("Enter choice:\t");
            int select = sc.nextInt();

            rs.absolute(select);
            restaurant = rs.getString("Restaurant_Name");

            o.setRestaurant_name(restaurant);

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    public void isDelivery(Order o) {
        String isDelivery;
        System.out.print("\nIs this order a delivery? (yes/no)");
        isDelivery = sc.next();
        o.setIs_delivery(isDelivery);

        try{
            if (isDelivery.equalsIgnoreCase("Yes")){
                String getDriver = "select * from Driver where restaurant_name = '" + o.getRestaurant_name() + "'";
                rs = statement.executeQuery(getDriver);
                rs.absolute(1);
                o.setCar_number(rs.getString("Car_Number"));
            } else {
                o.setCar_number("NULL");
            }
        } catch (SQLException sqle){
            sqle.printStackTrace();
        }
    }

    public void options(Order o) {

        System.out.println("\n***** " + o.getRestaurant_name() + " Options *****");
        System.out.println("[1]  Add Pizza");
        System.out.println("[2]  Finalize Order");

        System.out.print("Enter choice: ");
        int selection = sc.nextInt();

        if (selection == 1) {

            Pizza p = new Pizza();
            newPizzaID(p); //create a new pizza
            p.setRestaurant(o.getRestaurant_name()); //set pizza restaurant
            getFlavor(o, p); //set pizza flavor and + to price
            getCrust(o, p); //set pizza crust and + to price
            getSauce(o, p); //set pizza sauce
            p.setOrder_id(o.getOrder_id()); //match order ids
            o.addPizza(p); //add pizza to order
            o.addToOrderTotal(p.getPrice()); //add price to order total
            insertPizzaIntoDB(o, p); //insert pizza into the db
            options(o); //option to add more pizzas or finalize order

        } else if (selection == 2) {
            finalizeOrder(o); //adds pizza & order to order_pizza and prints information
        }
        else {
            System.out.println("You messed up....");
            menu();
        }
    }

    public void newPizzaID(Pizza p) {

        String selectOrders = "select pizza_id from pizza order by pizza_id;";

        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(selectOrders);
            rs.last();
            int pizza_id = Integer.parseInt(rs.getString("pizza_id"));
            p.setPizza_id(pizza_id + 1);

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

    }

    public void getFlavor(Order o, Pizza p) {

        String getPizzas = "SELECT * FROM Flavor where Restaurant_Name = '" + o.getRestaurant_name() + "';";
        int selection;

        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(getPizzas);
            int i = 1;

            System.out.println("\n***** " + o.getRestaurant_name() + " menu *****");

            while (rs.next()) {
                System.out.print("[" + i + "]\t");
                System.out.print("$" + rs.getString("price") + "\t");

                String flavor = rs.getString("flavor_name");
                System.out.println(flavor);

                String toppings = getToppings(flavor);
                System.out.println("\t" + toppings);
                i++;
            }

            System.out.print("Enter choice:\t");
            selection = sc.nextInt();

            rs.absolute(selection);
            String flavor = rs.getString("flavor_name");
            double price = Double.parseDouble(rs.getString("price"));

            p.setFlavor(flavor);
            p.addToPrice(price);

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    public String getToppings(String flavor) {

        String getToppings = "select topping_name from flavor_toppings where flavor_name = '" + flavor + "';";
        String returnToppings = "";

        try {
            statement = connection.createStatement();
            ResultSet rs1 = statement.executeQuery(getToppings);

            while (rs1.next()) {
                returnToppings += rs1.getString("topping_name") + ", ";
            }
            returnToppings = returnToppings.substring(0, returnToppings.length() - 1);

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

        return returnToppings.substring(0, returnToppings.length() - 1);

    }

    public void getCrust(Order o, Pizza p) {

        String getCrust = "SELECT * FROM Crusts WHERE restaurant_name = '" + o.getRestaurant_name() + "';";
        int selection;

        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(getCrust);
            int i = 1;

            System.out.println("\n***** " + o.getRestaurant_name() + " Crust Options *****");
            while (rs.next()) {
                System.out.print("[" + i + "]\t");
                System.out.println("\t+$" + rs.getString("price") + "\t" + rs.getString("crust_style") + " (" + rs.getString("size") + "\")");
                i++;
            }

            System.out.print("Enter choice:\t");
            selection = sc.nextInt();
            rs.absolute(selection);

            String crust = rs.getString("crust_style");
            double crustPrice = Double.parseDouble(rs.getString("price"));

            int size = Integer.parseInt(rs.getString("size"));

            p.setCrust(crust);
            p.setSize(size);
            p.addToPrice(crustPrice);

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

    }

    public void getSauce(Order o, Pizza p) {

        String getSauce = "SELECT * from Sauce WHERE Restaurant_Name = '" + o.getRestaurant_name() + "';";

        int selection;

        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(getSauce);
            int i = 1;

            System.out.println("\n***** " + o.getRestaurant_name() + " Sauce Options *****");

            while (rs.next()) {
                System.out.print("[" + i + "]\t");
                System.out.println("\t" + rs.getString("sauce_name"));
                i++;
            }

            System.out.print("Enter choice:\t");
            selection = sc.nextInt();
            rs.absolute(selection);

            String sauce = rs.getString("sauce_name");
            p.setSauce(sauce);

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

    }

    public void insertPizzaIntoDB(Order o, Pizza p) {

        String insertPizza = "INSERT INTO Pizza (Pizza_ID, Flavor_Name, Crust_Style, Size, Restaurant_Name, Sauce_Name)\n" +
                "VALUES (" + p.getPizza_id() + ",'"
                + p.getFlavor() + "','"
                + p.getCrust() + "',"
                + p.getSize() + ",'"
                + p.getRestaurant() + "','"
                + p.getSauce() + "');";

        String insertOrderPizza = "INSERT INTO Order_Pizza (Order_ID, Pizza_ID)\n" +
                "VALUES (" + o.getOrder_id() + "," +
                p.getPizza_id() + ");";

        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(insertPizza);
            rs = statement.executeQuery(insertOrderPizza);

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    public void insertOrderIntoDB(Order o){

        String insertOrder = "INSERT INTO Orders (Order_ID, Customer_Name, Restaurant_Name, Is_Delivery, Car_Number)\n" +
                "VALUES (" + o.getOrder_id() + ",'" +
                o.getCustomer_name() + "','" +
                o.getRestaurant_name() + "','" +
                o.getIs_delivery() + "',";

                if(o.getCar_number().equalsIgnoreCase("NULL")){
                    insertOrder += "NULL);";
                } else {
                    insertOrder += "'" + o.getCar_number() + "');";
                }

        try {
            statement = connection.createStatement();
            rs = statement.executeQuery(insertOrder);

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

    }

    public void finalizeOrder(Order o) {

        System.out.println("***** Order #" + o.getOrder_id() + " *****");

        String getCustomerInfo = "SELECT * FROM Customer Where Customer_Name = '" + o.getCustomer_name() + "';";
        String getRestaurantInfo = "SELECT * FROM Restaurant Where Restaurant_Name = '" + o.getRestaurant_name() + "';";
        String getDriver = "SELECT Driver_Name FROM Driver Where Car_Number = '" + o.getCar_number() + "';";

        ArrayList<Pizza> finalOrderPizzas = o.getPizzas();

        try {
            statement = connection.createStatement();

            rs = statement.executeQuery(getCustomerInfo);
            System.out.println("\n***** Customer *****");
            while (rs.next()) {
                System.out.println("  * " + rs.getString(1));
                System.out.println("  * " + rs.getString(2));
                System.out.println("  * " + rs.getString(3));
            }

            rs = statement.executeQuery(getRestaurantInfo);
            System.out.println("\n***** Restaurant *****");
            while (rs.next()) {
                System.out.println("  * " + rs.getString(1));
                System.out.println("  * " + rs.getString(2));
                System.out.println("  * " + rs.getString(3));
            }

            rs = statement.executeQuery(getDriver);
            while (rs.next()) {
                System.out.println("Delivered by: " + rs.getString(1));
            }

            System.out.println("\n***** Pizzas *****");
            System.out.println("Pizzas\tPrice\tDescription");

            for (int i = 0; i < finalOrderPizzas.size(); i++) {
                System.out.print("#" + (i+1) + "\t\t");
                System.out.printf("$%.2f\t", finalOrderPizzas.get(i).getPrice());
                System.out.println(finalOrderPizzas.get(i).toString());
            }

            System.out.printf("\nOrder Total $%.2f\t", o.getOrderTotal());

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
}

class Pizza {

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

class Order {

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

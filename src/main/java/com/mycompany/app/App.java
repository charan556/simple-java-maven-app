package com.mycompany.app;

/**
 * Hello world!
 */
public class App
{

    private final String message = "Hello World!";

    public App() {}

    public static void main(String[] args) {
        for(int i=1;i<=100;i++){
                System.out.println(new App().getMessage());
                Thread.sleep(5000);
        }
    }

    private final String getMessage() {
        return message;
    }

}

package Servlets;

import Classes.DatabaseInit;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class AddCarTypeServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");

        String json;
        PrintWriter out = response.getWriter();

        try {
            String car_name = request.getParameter("car_name");
            String car_picture = request.getParameter("car_picture");
//            String base64 = car_picture.substring(car_picture.indexOf(",") + 1,car_picture.length());
//            System.out.println(base64);
            String path = request.getSession().getServletContext().getRealPath("imagesss");
            System.out.println(path);
            String filename = car_name + ".png";
            File file = new File(path,filename);
            if(file.exists())
            {
                System.out.println("已存在");
            }
            else
            {
                System.out.println("不存在");
            }
//            file.createNewFile();
//            FileOutputStream write = new FileOutputStream(file);
//            byte[] decoderBytes = Base64.getDecoder().decode(base64);
//            write.write(decoderBytes);
//            write.close();
//            System.out.println("success");

            String car_brand = request.getParameter("car_brand");
            String car_type = request.getParameter("car_type");
            float daily_rent = Float.parseFloat(request.getParameter("daily_rent"));
            float car_deposit = Float.parseFloat(request.getParameter("car_deposit"));

            Connection conn = DatabaseInit.getConnection();
            String sql = "insert into car.car_type(car_name, car_picture, car_brand, car_type, daily_rent, car_deposit) values (?, ?, ?, ?, ?, ?);";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, car_name);
            ps.setString(2, car_picture);
            ps.setString(3, car_brand);
            ps.setString(4, car_type);
            ps.setFloat(5, daily_rent);
            ps.setFloat(6, car_deposit);
            ps.executeUpdate();
        } catch (Exception e) {
            json = "{\"code\": \"1\"}";
            out.println(JSONObject.fromObject(json));
            out.close();
            e.printStackTrace();
        }

        json = "{\"code\": \"0\"}";
        out.println(JSONObject.fromObject(json));
        out.close();
    }
}

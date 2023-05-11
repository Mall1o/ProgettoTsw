package it.unisa.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.model.Cart;


@WebServlet("/Checkout")
public class OrderControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
    public OrderControl() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session = request.getSession();
		
		String user = (String) session.getAttribute("user");
		
//		if(user == null)
//			response.sendRedirect("loginForm.jsp");
		
		
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		
		System.out.println(cart.getProducts().get(0).toString());
		System.out.println(cart.getProducts().get(1).toString());
		System.out.println(request.getParameter("payment"));

	}

}

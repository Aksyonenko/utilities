package com.aksyon.utilities;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/utilitiesServlet")
public class UtilitiesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Map<String, BigDecimal> utilityMap = Collections.synchronizedMap(new HashMap<>());

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.getWriter().write(new Gson().toJson(utilityMap));
    }

    @Override
    protected void doPost(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {
        utilityMap.putAll(new Gson().fromJson(request.getReader(), Map.class));
    }

}

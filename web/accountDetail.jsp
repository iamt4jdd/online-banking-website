<%@page import="DAO.PaymentAccountDAO"%>
<%@page import="business.PaymentAccount"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/checkLogin.jsp" %>



<%  
    PaymentAccount paymentAccount = (PaymentAccount) request.getAttribute("paymentAccount");
%>


<div class="bg-[#f0f1f1] mt-[5.2rem] pb-16">
    <div class="py-16 mx-56">
        <div class="flex text-2xl">
            <a href="./index.jsp"><i class="fa-solid fa-chevron-left text-xl py-[0.3rem] pr-6"></i></a>
            <div class="py-[0.2rem]">Account</div>
        </div>

        <nav class="flex pt-3 ml-[2.3rem]" aria-label="Breadcrumb">
            <ol class="inline-flex items-center space-x-1 md:space-x-3">
                <li class="inline-flex items-center">
                    <a
                        href="./profile.jsp"
                        class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-blue-600"
                        >
                        <svg
                            class="w-3 h-3 mr-2.5"
                            aria-hidden="true"
                            xmlns="http://www.w3.org/2000/svg"
                            fill="#000"
                            viewBox="0 0 20 20"
                            >
                            <path
                                d="m19.707 9.293-2-2-7-7a1 1 0 0 0-1.414 0l-7 7-2 2a1 1 0 0 0 1.414 1.414L2 10.414V18a2 2 0 0 0 2 2h3a1 1 0 0 0 1-1v-4a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v4a1 1 0 0 0 1 1h3a2 2 0 0 0 2-2v-7.586l.293.293a1 1 0 0 0 1.414-1.414Z"
                                />
                        </svg>
                        Home
                    </a>
                </li>
                <li>
                    <div class="flex items-center">
                        <svg class="w-3 h-3 mx-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 9 4-4-4-4"/>
                        </svg>
                        <form action="show-account" method="get"><button type="submit" class="ml-1 text-sm font-medium hover:text-blue-600 md:ml-2">Account</button></form>
                    </div>
                </li>
                <li>
                    <div class="flex items-center">
                        <svg class="w-3 h-3 mx-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 9 4-4-4-4"/>
                        </svg>
                        <a class="ml-1 text-sm font-medium text-blue-600 md:ml-2 cursor-pointer">Account Detail</a>
                    </div>
                </li>
            </ol>
        </nav>

        <div class="grid grid-cols-6 gap-8">
            <div class="col-span-4 my-16 py-8 px-20 rounded-xl bg-white">
                <div class='w-full grid grid-cols-1'>
                    <div class='grid grid-cols-3 border-b-2 py-2 mb-3'>
                        <div class="text-gray-500 text-sm">10/11/2023 19:17:58</div>
                        <div class="col-span-2 text-end text-gray-500 text-sm">Trans Id: 0599G6PO-7mcjsKuR6</div>
                        <div class="col-span-2">8890743713 Thang nao do Chuyen tien</div>
                        <div class="text-end text-xl text-green-400">+200,000 VND</div>
                    </div>
                    <div class='grid grid-cols-3 border-b-2 py-2 mb-3'>
                        <div class="text-gray-500 text-sm">10/11/2023 19:17:58</div>
                        <div class="col-span-2 text-end text-gray-500 text-sm">Trans Id: 978Gk9O-7msdcsTq4V</div>
                        <div class="col-span-2">8890743713 Thang nao do Mat tien</div>
                        <div class="text-end text-xl text-red-400">-200,000 VND</div>
                    </div>
                </div>
            </div>
            <div class="col-span-2 my-16 rounded-xl bg-white">
                <div class="flex justify-between bg-gradient-to-r from-[#3caff2] to-[#2267a8] rounded-t-xl">
                    <div class="flex flex-col justify-center items-center ml-8 text-white">
                        <span class="uppercase text-sm"><%= customer.getName()%></span>
                        <span class="uppercase text-sm"><%= paymentAccount.getAccountNumber()%></span>
                    </div>
                    <img src="assets/thanh-toan.svg" src="wallet" class="p-4"/>
                </div>
                <div class='w-full grid grid-cols-1 gap-2 p-8'>
                    <div class='flex justify-between items-center'>
                        <span class="text-gray-500 text-sm">Account Name</span>
                        <span class="uppercase text-sm"><%= customer.getName()%></span>
                    </div>
                    <div class='flex justify-between items-center'>
                        <span class="text-gray-500 text-sm">Account Number</span>
                        <span class="uppercase text-sm"><%= paymentAccount.getAccountNumber()%></span>
                    </div> 
                    <div class='flex justify-between items-center'>
                        <span class="text-gray-500 text-sm">Account Type</span>
                        <span class="uppercase text-sm"><%= paymentAccount.getAccountType()%></span>
                    </div>
                    <div class='flex justify-between items-center'>
                        <span class="text-gray-500 text-sm">Account Opening Date</span>
                        <span class="uppercase text-sm"><%= paymentAccount.getDateOpened()%></span>
                    </div>   
                    <div class='flex justify-between items-center'>
                        <span class="text-gray-500 text-sm">Account Balance</span>
                        <span class="uppercase text-sm"><%= paymentAccount.getCurrentBalence()%> VND</span>
                    </div>   
                    <div class='flex justify-between items-center'>
                        <span class="text-gray-500 text-sm">Reward Pointp           </span>
                        <span class="uppercase text-sm"><%= paymentAccount.getRewardPoint()%> RWP</span>
                    </div>  
                    <div class='flex justify-between items-center'>
                        <span class="text-gray-500 text-sm">Registered Branch</span>
                        <span class="uppercase text-sm">NND Banking</span>
                    </div>  
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>

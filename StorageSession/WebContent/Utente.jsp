<%@page import="java.util.ArrayList"%>
<%@page import="it.unisa.model.OrderDaoImpl"%>
<%@ page import="it.unisa.model.UserDaoImpl" %>
<%@ page import="it.unisa.model.UserBean" %>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.model.AddressBean" %>
<%@ page import="it.unisa.model.OrderBean" %>
<%@ page import="it.unisa.control.AddressControl" %>
<%@ page import="it.unisa.model.AddressDaoImpl" %>
<%@ page import="it.unisa.control.OrderControl" %>
<%@ page import="it.unisa.control.ModifyControl" %>
<%

	UserBean user = (UserBean) session.getAttribute("user");
	AddressDaoImpl addressDao = new AddressDaoImpl();
	OrderDaoImpl orderDao = new OrderDaoImpl();
	List<AddressBean> indirizzi = new ArrayList<AddressBean>();
	List<OrderBean> ordini = new ArrayList<OrderBean>();
	if(user == null){
		response.sendRedirect("loginForm.jsp");
	}else{
		indirizzi = addressDao.findByID(user.getId());
		ordini = orderDao.findByIdUtente(user.getId());
	}
%>

<!DOCTYPE html>
<html>
   <head>
      <title>Dettagli Utente</title>
	  <style>
	      .hidden {
	         display: none;
	      }
	      .placeholder {
			  color: #65657b;
			  font-family: sans-serif;
			  left: 20px;
			  line-height: 14px;
			  pointer-events: none;
			  position: absolute;
			  transform-origin: 0 50%;
			  transition: transform 200ms, color 200ms;
			  top: 20px;
			}
	  </style>
	  <script>
         function showEmailInput() {
            var emailLabel = document.getElementById("emailLabel");
            var emailInput = document.getElementById("emailInput");
            var editButton = document.getElementById("editButton");
            var submitButton = document.getElementById("submitButton");

            emailLabel.classList.add("hidden");
            emailInput.classList.remove("hidden");
            editButton.classList.add("hidden");
            submitButton.classList.remove("hidden");
         }
         
         function showPhoneInput() {
            var phoneLabel = document.getElementById("phoneLabel");
            var phoneInput = document.getElementById("phoneInput");
            var editButton = document.getElementById("editPhoneButton");
            var submitButton = document.getElementById("submitPhoneButton");

            phoneLabel.classList.add("hidden");
            phoneInput.classList.remove("hidden");
            editButton.classList.add("hidden");
            submitButton.classList.remove("hidden");
         }
         
         var oldPasswordInput;
         var newPasswordInput;

         function showPasswordInputs() {
             oldPasswordInput = document.getElementById("oldPasswordInput");
             newPasswordInput = document.getElementById("newPasswordInput");
             var editPasswordButton = document.getElementById("editPasswordButton");
             var submitPasswordButton = document.getElementById("submitPasswordButton");

             oldPasswordInput.classList.remove("hidden");
             newPasswordInput.classList.remove("hidden");
             editPasswordButton.classList.add("hidden");
             submitPasswordButton.classList.remove("hidden");
         }
         
         function submitEmail() {
        	    var emailInput = document.getElementById("emailInput").value;

        	    // Effettua la chiamata AJAX per inviare la nuova email alla servlet
        	    var xhttp = new XMLHttpRequest();
        	    xhttp.onreadystatechange = function() {
        	        if (this.readyState === 4) {
        	            if (this.status === 200) {
        	            	var responseJson = JSON.parse(this.responseText);
        	                var newEmail = responseJson.email;
        	                alert("Email modificata con successo! Ti abbiamo inviato una mail di conferma.");
        	                document.getElementById("emailLabel").textContent = newEmail;
        	                // Reimposta il form alla situazione iniziale
        	                document.getElementById("emailInput").classList.add("hidden");
        	                document.getElementById("emailInput").value = '';
        	                document.getElementById("emailLabel").classList.remove("hidden");
        	                document.getElementById("editButton").classList.remove("hidden");
        	                document.getElementById("submitButton").classList.add("hidden");
        	            } else {
        	                alert("Si � verificato un errore durante la modifica dell'email. Riprova pi� tardi.");
        	                document.getElementById("emailInput").disabled = false;
        	                document.getElementById("submitButton").disabled = false;
        	            }
        	        }
        	    };
        	    xhttp.open("POST", "modify", true);
        	    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        	    xhttp.send("action=modificaEmail&nuovaEmail=" + encodeURIComponent(emailInput));
        	}

        	function submitPhone() {
        	    var phoneInput = document.getElementById("phoneInput").value;

        	    // Effettua la chiamata AJAX per inviare il nuovo numero di cellulare alla servlet
        	    var xhttp = new XMLHttpRequest();
        	    xhttp.onreadystatechange = function() {
        	        if (this.readyState === 4) {
        	            if (this.status === 200) {
        	            	var responseJson = JSON.parse(this.responseText);
        	                var newCell = responseJson.numTelefono;
        	                alert("Numero di cellulare modificato con successo!");
        	                document.getElementById("phoneLabel").textContent = newCell;
        	                // Reimposta il form alla situazione iniziale
        	                document.getElementById("phoneInput").classList.add("hidden");
        	                document.getElementById("phoneInput").value = '';
        	                document.getElementById("phoneLabel").classList.remove("hidden");
        	                document.getElementById("editPhoneButton").classList.remove("hidden");
        	                document.getElementById("submitPhoneButton").classList.add("hidden");
        	            } else {
        	                alert("Si � verificato un errore durante la modifica del numero di cellulare. Riprova pi� tardi.");
        	                document.getElementById("phoneInput").disabled = false;
        	                document.getElementById("submitPhoneButton").disabled = false;
        	            }
        	        }
        	    };
        	    xhttp.open("POST", "modify", true);
        	    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        	    xhttp.send("action=modificaTelefono&nuovoTelefono=" + encodeURIComponent(phoneInput));
        	}
        	
        	function submitPassword() {
                var oldPassword = oldPasswordInput.value;
                var newPassword = newPasswordInput.value;

                // Effettua la chiamata AJAX per inviare la vecchia e la nuova password alla servlet
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (this.readyState === 4) {
                        if (this.status === 200) {
                            var responseJson = JSON.parse(this.responseText);
                            if (responseJson.success) {
                                alert("Password modificata con successo!");
                                // Reimposta il form alla situazione iniziale
                                oldPasswordInput.classList.add("hidden");
                                oldPasswordInput.value = '';
                                newPasswordInput.classList.add("hidden");
                                newPasswordInput.value = '';
                                document.getElementById("editPasswordButton").classList.remove("hidden");
                                document.getElementById("submitPasswordButton").classList.add("hidden");
                            } else {
                                alert("Vecchia password errata. Riprova.");
                            }
                        } else {
                            alert("Si � verificato un errore durante la modifica della password. Riprova pi� tardi.");
                        }
                    }
                };
                xhttp.open("POST", "modify", true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send("action=modificaPassword&vecchiaPassword=" + encodeURIComponent(oldPassword) + "&nuovaPassword=" + encodeURIComponent(newPassword));
            }
      </script>
   </head>
   <body>
      <%if(user != null) {%>
      <%@include file="Header.jsp"%>
      <br>  <br>
      <h1>Dettagli Utente</h1>
      <p>Benvenuto, <%= user.getNome().toUpperCase() %>!</p>
      <p>Nome: <%= user.getNome() %></p>
      <p>Cognome: <%= user.getCognome() %></p>
      <p>Data di nascita: <%= user.getDataNascita() %></p>
      <label id="emailLabel">Email: <%= user.getEmail() %></label>
	  <input type="text" id="emailInput" class="hidden" required/>
	  <button id="editButton" onclick="showEmailInput()">Modifica Email</button>
	  <button id="submitButton" class="hidden" onclick="submitEmail()">Conferma</button>
	  <br>
	  <button id="editPhoneButton" onclick="showPhoneInput()">Modifica Numero di cellulare</button>
      <label id="phoneLabel">Numero di cellulare: <%= user.getNumTelefono() %></label>
	  <input type="text" id="phoneInput" class="hidden" required/>
	  <button id="submitPhoneButton" class="hidden" onclick="submitPhone()">Conferma</button>
	  <br>
      <button id="editPasswordButton"  onclick="showPasswordInputs()">Modifica Password</button>
	  <input type="text" id="oldPasswordInput" class="hidden" placeholder="Vecchia password" required/>
	  <input type="text" id="newPasswordInput"  class="hidden" placeholder="Nuova password" required/>
	  <button id="submitPasswordButton" class="hidden" onclick="submitPassword()">Conferma</button>
      <br>

      <h2>Indirizzi</h2>
      <table>
         <thead>
            <tr>
               <th>Indirizzo</th>
               <th>Citt�</th>
               <th>Provincia</th>
            </tr>
         </thead>
         <tbody>
            <% for (AddressBean indirizzo : indirizzi) { %>
               <tr>
                  <td><%= indirizzo.getVia() %></td>
                  <td><%= indirizzo.getCitta() %></td>
                  <td><%= indirizzo.getProvincia() %></td>
               </tr>
            <% } %>
         </tbody>
      </table>
      <button onclick="location.href='AddressForm.jsp'">Aggiungi indirizzo</button>
      <br>

      <h2>Ordini Effettuati</h2>
      <table>
         <thead>
            <tr>
               <th>ID Ordine</th>
               <th>Data Ordine</th>
               <th>Totale</th>
            </tr>
         </thead>
         <tbody>
            <% for (OrderBean ordine : ordini) { %>
               <tr>
                  <td><%= ordine.getId_ordine() %></td>
                  <td><%= ordine.getDataAcquisto() %></td>
                  <td><%= ordine.getPrezzoTot() %></td>
               </tr>
            <% } %>
         </tbody>
      </table>

      <%@include file="Footer.jsp"%>
	<%}%>
   </body>
</html>

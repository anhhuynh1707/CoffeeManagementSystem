<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Matcha Coffee | Home</title>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/index.css">
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</head>

<body>

	<div class="navbar">

		<!-- LEFT: LOGO -->
		<a href="${pageContext.request.contextPath}/index.jsp"
			class="logo-link"> Matcha Coffee ☕ </a>

		<!-- RIGHT: ACTIONS -->
		<div class="nav-actions">
			<!-- USER -->
			<div class="user-menu" id="userMenu">
				<span class="user-name"> 👤
					${sessionScope.currentUser.fullName} </span>

				<div class="dropdown" id="dropdownMenu">
					<a href="${pageContext.request.contextPath}/menu">Menu</a> <a
						href="${pageContext.request.contextPath}/profile">Profile</a> <a
						href="${pageContext.request.contextPath}/my-orders">Orders</a>
					<hr>
					<a href="${pageContext.request.contextPath}/logout" class="logout">
						Logout </a>
				</div>
				<!-- CART -->
				<a href="${pageContext.request.contextPath}/cart" class="cart-btn">
					🛒 <c:if test="${sessionScope.cartCount > 0}">
						<span class="cart-badge">${sessionScope.cartCount}</span>
					</c:if>
				</a>
			</div>

		</div>
	</div>

	<!-- HERO SECTION -->
	<div class="wrapper">
		<div class="hero hero-bg">
			<h1>Fresh Matcha • Fresh Coffee</h1>
			<p>Experience the calming taste of matcha and the aroma of fresh
				brew — all in one place
			</p>
			<a href="${pageContext.request.contextPath}/menu" class="btn-primary">Explore
				Menu</a>
		</div>

		<!-- FEATURE GRID -->
		<div class="features">

			<div class="feature-card">
				<h3>🍵 Matcha & Coffee Menu</h3>
				<p>Browse all drinks and items available in our café.</p>
				<a href="menu" class="btn-primary">View Menu</a>
			</div>

			<div class="feature-card">
				<h3>🛒 Cart System</h3>
				<p>Add drinks, customize orders, and checkout easily.</p>
				<a href="cart" class="btn-primary">Go to Cart</a>
			</div>

			<div class="feature-card">
				<h3>👤 Your Profile</h3>
				<p>Edit your info, address, and preferences.</p>
				<a href="profile" class="btn-primary">Profile</a>
			</div>

			<div class="feature-card">
				<h3>📦 Order History</h3>
				<p>Track all your previous and ongoing orders.</p>
				<a href="my-orders" class="btn-primary">View Orders</a>
			</div>
		</div>
		<section class="about about-flex">
			<img src="${pageContext.request.contextPath}/img/index/matcha.jpg" alt="Matcha preparation">
         <div>
		    <h2>About Matcha Coffee 🍃</h2>
		    <p>
		        Matcha Coffee is a cozy café where Japanese matcha tradition meets
		        modern coffee culture. We believe that every cup should bring calm,
		        balance, and joy — whether you're starting your day or taking a break.
		    </p>
		    <p>
		        From ceremonial-grade matcha to freshly roasted coffee beans,
		        every ingredient is carefully selected to deliver a smooth,
		        rich, and authentic taste.
		    </p>
		    </div>
		</section>
		<section class="why-matcha">
		    <h2>Why Choose Our Matcha?</h2>
		
		    <div class="why-grid">
		        <div class="why-item">
		            <h3>🌱 Premium Quality</h3>
		            <p>Ceremonial-grade matcha sourced directly from Japan.</p>
		        </div>
		
		        <div class="why-item">
		            <h3>🧘 Calm Energy</h3>
		            <p>Rich in L-theanine for focus without caffeine crashes.</p>
		        </div>
		
		        <div class="why-item">
		            <h3>🥛 Fully Customizable</h3>
		            <p>Choose milk, sugar level, ice, and toppings your way.</p>
		        </div>
		
		        <div class="why-item">
		            <h3>💚 Health-Focused</h3>
		            <p>Antioxidant-rich drinks crafted with care.</p>
		        </div>
		    </div>
		</section>
		<section class="signature">
		    <h2>Signature Drinks ⭐</h2>
		
		    <div class="signature-grid">
		        <div class="signature-card">
		        	<img src="${pageContext.request.contextPath}/img/index/matcha-latte.jpg" alt="Matcha Latte">
		            <h3>Matcha Latte</h3>
		            <p>Classic, creamy, and perfectly balanced.</p>
		        </div>
		
		        <div class="signature-card">
		            <img src="${pageContext.request.contextPath}/img/index/espresso-matcha.jpg" alt="Matcha Espresso">
		            <h3>Matcha Espresso Fusion</h3>
		            <p>Bold espresso meets smooth matcha.</p>
		        </div>
		
		        <div class="signature-card">
		        	<img src="${pageContext.request.contextPath}/img/index/ice-matcha.jpg" alt="Iced Matcha">
		            <h3>Iced Matcha Latte</h3>
		            <p>Refreshing and energizing for hot days.</p>
		        </div>
		
		        <div class="signature-card">
		        	<img src="${pageContext.request.contextPath}/img/index/frappe-matcha.jpg" alt="Matcha Frappe">
		            <h3>Matcha Frappe</h3>
		            <p>Blended perfection with a sweet finish.</p>
		        </div>
		    </div>
		</section>
		<section class="experience experience-bg">
		    <h1>The Matcha Coffee Experience</h1>
		    <p>
		        Whether you're studying, working, or relaxing,
		        Matcha Coffee offers a peaceful space with warm lighting,
		        soft music, and a calming green aesthetic.
		    </p>
		    <p>
		        Our shop is designed for slow moments - where you can
		        sip mindfully and enjoy the art of tea and coffee.
		    </p>
		</section>
		<section class="cta">
			<img src="${pageContext.request.contextPath}/img/index/matcha-latte.jpg" alt="Matcha drink" class="cta-img">
		    <h2>Ready to Enjoy a Cup? ☕</h2>
		    <p>Explore our menu and create your perfect drink today.</p>
		    <a href="${pageContext.request.contextPath}/menu" class="btn-primary">
		        Browse Menu
		    </a>
		</section>
		
		
		
	</div>

	<!-- FOOTER -->
	<div class="footer">Matcha Coffee © 2025 — Brewed with love 🍃</div>

</body>
</html>

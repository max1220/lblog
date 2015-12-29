<!DOCTYPE html>
<html>
	<head>
		<title>Comments</title>
	</head>
	<body style="max-width: 800px; margin:auto;">
		<h1>Comments</h1>
		<p><b>Please enter username and comment below.</b></p>
		<form method="post">
			<p>
			Username: <input type="text" name="username">
			</p>
			<p>
			Password: <input type="text" name="comment">
			</p>
			<input type="submit" value="Send">
		</form>
		<hr>
		<h2>Older comments</h2>
		<p>
			{{#comments}}
				<p><b>{{username}}:{{comment}}</b></p>
			{{/comments}}
		<p>
	</body>
</html>

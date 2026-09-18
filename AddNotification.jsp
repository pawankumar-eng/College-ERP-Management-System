<h2>Send Notification</h2>

<form action="AddNotificationServlet" method="post">

Title:
<input type="text" name="title" required>

<br><br>

Message:
<br>
<textarea name="message" rows="5" cols="40" required></textarea>

<br><br>

Sender:
<input type="text" name="sender" required>

<br><br>

Target Role:
<select name="target_role">
    <option>ALL</option>
    <option>STUDENT</option>
    <option>TEACHER</option>
</select>

<br><br>

<input type="submit" value="Send Notification">

</form>
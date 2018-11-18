<html>
<head>
    <title>problema 2</title>
</head>
<body>

<form action="problema2.php">
    <label>Id (fara SQL Injection):</label>
    <input type="text" name="id" placeholder="Ex: 222" required>
    <input type="submit" value="Submit">
</form>

<?php

$username = 'STUDENT';
$password = 'STUDENT';
$connection_string = 'localhost/xe';
$connection = oci_connect($username, $password, $connection_string);


@$var = $_GET['id'];
$query = "SELECT ID, QUESTION, ANSWER from QUESTIONS where id=:bind";
$result = oci_parse($connection, $query);
oci_bind_by_name($result, ':bind', $var);
@$row = oci_execute($result);
while ($row = @oci_fetch_array($result, OCI_ASSOC+OCI_RETURN_LOBS))
{
    echo "_________________________________________________________________________________________________________________________________________________________________________";
    echo "<br>";
    echo 'Id-ul intrebarii: '.$row['ID'] . "<br>";
    echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
    echo "<br>";
    echo 'Intrebarea: '. $row['QUESTION'] . "<br>";
    echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
    echo "<br>";
    echo 'Raspunsul: '. $row['ANSWER'] . "<br>" ;
    echo "_________________________________________________________________________________________________________________________________________________________________________";

}

function existaIntrebarea($x)
{
    $username = 'STUDENT';
    $password = 'STUDENT';
    $connection_string = 'localhost/xe';
    $connection = oci_connect($username, $password, $connection_string);
    $stid = oci_parse($connection, "SELECT count(*) c from QUESTIONS where id=:bind");
    oci_bind_by_name($stid, ':bind', $x);
    @oci_execute($stid);
    @oci_fetch_all($stid, $res);
    if(@$res['C'][0] == 0)
        throw new Exception('Intrebarea cu id-ul '.$x.' nu exista!');
}

try {
    existaIntrebarea($var);
} catch (Exception $e) {
    echo 'Caught exception: ',  $e->getMessage(), "\n";
}
If (!$connection)
    echo 'Connection failed';

oci_close($connection);

?>

<br><br>
<form action="problema2.php">
    <label>Id (cu SQL Injection):</label>
    <input type="text" name="id2" placeholder="SQL Injection: '' or 1=1" required>
    <input type="submit" value="Submit">
</form>

<?php

$username = 'STUDENT';
$password = 'STUDENT';
$connection_string = 'localhost/xe';
$connection = oci_connect($username, $password, $connection_string);


@$var3 = $_GET['id2'];
$query3 = "SELECT ID, QUESTION, ANSWER from QUESTIONS where id=$var3";
$result3 = oci_parse($connection, $query3);
$row3 = @oci_execute($result3);
while ($row3 = @oci_fetch_array($result3, OCI_ASSOC+OCI_RETURN_LOBS))
{
    echo "_________________________________________________________________________________________________________________________________________________________________________";
    echo "<br>";
    echo 'Id-ul intrebarii: '.$row3['ID'] . "<br>";
    echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
    echo "<br>";
    echo 'Intrebarea: '. $row3['QUESTION'] . "<br>";
     echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
    echo "<br>";
    echo 'Raspunsul: '. $row3['ANSWER'] . "<br>" ;
    echo "_________________________________________________________________________________________________________________________________________________________________________";

}

function existaIntrebarea2($x)
{
    $username = 'STUDENT';
    $password = 'STUDENT';
    $connection_string = 'localhost/xe';
    $connection = oci_connect($username, $password, $connection_string);
    $stid = oci_parse($connection, "SELECT count(*) c from QUESTIONS where id=$x");
    @oci_execute($stid);
    @oci_fetch_all($stid, $res);
    if(@$res['C'][0] == 0)
        throw new Exception('Intrebarea cu id-ul '.$x.' nu exista!');
}

try {
    existaIntrebarea2($var3);
} catch (Exception $e3) {
    echo 'Caught exception: ',  $e3->getMessage(), "\n";
}


If (!$connection)
    echo 'Connection failed';

oci_close($connection);

?>

</body>
</html>





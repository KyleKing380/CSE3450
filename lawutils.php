<?php

// Function createa DB connection

function connectToDB()
{   
    global $conn;
    
    $servername = "localhost";
    $username = "root";         // Local Bitname Server
    $password = "newpassword";
    $dbname = "lawfirmdb";     // Local Bitname Server

	$conn = new mysqli($servername, $username, $password, $dbname);
    
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
  
   
}

// Function for inserting records to a database. Here 
function insertClientRecord()
{
    global $conn;
    
    $cid = $_POST['cid'];
    $cfname = $_POST['cfname'];
    $clname = $_POST['clname'];
    $clawid = $_POST['clawid'];
        
    if (!empty($cid) && !empty($cfname) && !empty(clname) && !empty(clawid)){
        $sql = "insert into LAWCLIENT (CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, LAWYER_ID)" .
                    " values ('$cid', '$cfname', '$clname', '$clawid')";
        if ($conn->query ($sql) == TRUE) {
            //echo "DEBUG: Record added <br>";
        }
        else
        {
            echo "Could not add record: " . $conn->connect_error . "<br>";
        }
    } 
    else
    {
        echo "Invalid <br>";
        $action = 'showInsertForm';
    }
}

function deleteClientRecord()
{
    global $conn;
    $cid = $_POST['cid'];
    if (!empty($cid)){
        $sql = "delete from LAWCLIENT where CLIENT_ID = '$cid'";
        
        if ($conn->query ($sql) == TRUE) {
            //echo "DEBUG: Record deleted <br>";
        }
        else
        {
            echo "Could not add record: " . $conn->connect_error . "<br>";
        }
    }
    else
    {
        echo "Must provide a CLIENT_ID to delete a record <br>";
    }
}


function showClientRecords()
{
    global $conn;
    global $thisPHP;
    
    echo "<form id='insertForm' action='{$thisPHP}' method='post'>";
    echo "<fieldset><legend>Click to Insert New Client to database</legend>";
    echo "<input type='submit' name='showInsertForm' value='Add New Client'>";
    echo "</form></fieldset>";
    
    $sql = "SELECT * FROM LAWCLIENT";
    $result = $conn->query($sql);
    
    if ($result->num_rows > 0) 
    {         
        echo "<h4>Client Database</h4>";
        echo "<table>";
        echo "<thead><tr><td>Client Id</td> <td>Client First Name </td> <td>Client Last Name</td><td>Lawyer Id</td> ";
        echo " <td> Delete? </td></tr></thead>";   
        while($row = $result->fetch_assoc()) 
        {
            echo "<tbody><tr>";
            $cid = $row["CLIENT_ID"];
            echo  "<td>" . $cid . "  </td> <td> " . $row["CLIENT_FNAME"] . 
                  " </td> <td> " . $row["CLIENT_LNAME"] . 
    		      " </td> <td> " . $row["LAWYER_ID"] .  
                  "</td>  <td> "; 
               
            echo "<form action='{$thisPHP}' method='post' style='display:inline' >";
            echo "<input type='hidden' name='cid' value='{$cid}'>";
            echo "<input type='submit' name='btnDelete' value='Delete'></form>";
            echo "</td></tr></tbody>";
        }
        
        echo "</table>";
    } 
    else 
    {
        echo "0 results";
    }
}


function displayInsertForm()
{
    global $thisPHP;
    
    // A heredoc for specifying really long strings
    $str = <<<EOD
    <form action='{$thisPHP}' method='post'>
    <fieldset>
        <legend>Client Data Entry</legend> Client Id:
        <input type="text" name="cid" size="10">
        <br> First Name:
        <input type="text" name="cfname" size="30">
        <br> Last Name:
        <input type="text" name="clname" size="20">
        <br> Lawyer Id:
        <input type="text" name="clawid" size="15">
        <input type="submit" name="btnInsert" value="Insert"><br>
    </fieldset>
    </form>
EOD;

    echo $str;
}
?>

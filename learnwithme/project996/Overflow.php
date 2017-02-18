<?php

function simulateSend(){
    yield 10;
    yield 20;
    yield 30;
    yield 40;
    yield 10;
    yield 20;
    yield 30;
    yield 10;
    yield 20;
    yield 30;
}

function insertReading($nNewValue){
    // Create connection
    $conn = new mysqli("127.0.0.1", "root", "password", "test");

    //Retrieve previous reading record
    $sql = "SELECT * FROM Readings ORDER BY ID DESC LIMIT 1;";
    $result = $conn->query($sql);

    //If there is no past record of reading
    if(0==$result->num_rows){
        $sql = "INSERT INTO Readings (displayValue, previousValue, accumulator)
                VALUES ($nNewValue, $nNewValue, 0)";
        $conn->query($sql);
    }else {
        $row = $result->fetch_assoc();
        $nPreValue = (int) $row['previousValue'];
        $nAccumulator = (int) $row['accumulator'];

        //If new value is less than previous value
        $nNewAccumulator = $nNewValue < $nPreValue ? ($nPreValue + $nAccumulator) : $nAccumulator;
        $nNewDisplayValue = $nNewValue + $nNewAccumulator;
        $sql = "INSERT INTO Readings (displayValue, previousValue, accumulator)
                VALUES ($nNewDisplayValue, $nNewValue, $nNewAccumulator)";
        $conn->query($sql);
    }

    // Close connection
    $conn->close();
}

function listReading(){
    // Create connection
    $conn = new mysqli("127.0.0.1", "root", "password", "test");

    //Retrieve previous reading record
    $sql = "SELECT * FROM Readings";
    $result = $conn->query($sql);

    echo "<table border='1'>";
    echo "<tr><td>ID</td><td>Display Value</td><td>Previous Value</td><td>Accumulator</td></tr>";
    while ($row = $result->fetch_object())
      {
       echo "<tr>";
       echo "<td>" . $row->ID . "</td>";
       echo "<td>" . $row->displayValue . "</td>";
       echo "<td>" . $row->previousValue . "</td>";
       echo "<td>" . $row->accumulator . "</td>";
       echo "</tr>";
      }
      echo '</table>';

    //If require to clear all values (?)
    // $sql = "DELETE FROM Readings";
    // $result = $conn->query($sql);

    // Close connection
    $conn->close();
}

//Simulating new value been send over
$generator = simulateSend();
foreach ($generator as $gen) {
    insertReading($gen);
}

//'var_dump' of records
listReading();
?>

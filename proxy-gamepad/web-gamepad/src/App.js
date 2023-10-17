import './App.css';
import { useState, useEffect } from 'react';
import {Button} from './components/Button';
import {PlaceHolder} from './components/PlaceHolder';
import { TouchPad } from './components/TouchPad';

function App() {
  const MaxSize = 5;

  useEffect(()=>{
    screen.orientation.addEventListener("change", function(e) {
      setisPortrait(getIsPortrait());
    });
  }, []);


  function uuidv4() {
    return "10000000-1000-4000-8000-100000000000".replace(/[018]/g, c =>
      (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    );
  }

  function getIsPortrait(){
    return screen.orientation.type.includes("portrait");
  }

  function maximiZe(){
    let app = document.getElementById("App");
    try {
      app.requestFullscreen();
    } catch (exceptionVar) {
    }
  }

  function login_fn() {
    let name = document.querySelector("#name_input").value;
    if (name && name.length <= MaxSize) {
      setloggedIn(true);
      setnameSelected(name);

      let url = `http://${process.env.REACT_APP_LOCAL_IP}:8001/join/${playerid}|${name}`
      try {
        fetch(url);
      } catch (error) {
        return 0;
      }
    }
  }

  const [loggedIn, setloggedIn] = useState(false);
  const [nameSelected, setnameSelected] = useState("");
  const [playerid, setplayerid] = useState(uuidv4());
  const [isPortrait, setisPortrait] = useState(getIsPortrait());
  //const [accel, setaccel] = useState();

  /*
  useEffect(() => {
    window.addEventListener('devicemotion', function (event) {
      console.log(event.acceleration.x);
      console.log(event.acceleration.y);
      setaccel(event?.acceleration?.y)
  }, true);
  });
  */

  return (
    <div id = "App" className="App">
      {loggedIn
        ?
      <body>
        <div className='center'>{nameSelected}</div>
        <TouchPad className="button" playerid={playerid} nameselected={nameSelected}></TouchPad>
        <PlaceHolder className="cross_place" id="dum" name="↑"/>
        <Button className="button" id="a" playerid={playerid} nameselected={nameSelected} name="!"/>
        <div></div>
      </body>
      :
      !isPortrait
      ?
      <body>
        <label for="name_input">MY NAME IS: </label><br></br>
        <input onFocus={maximiZe} className="join_input" id="name_input" maxLength={MaxSize}></input>
        <input className="join_button" type="submit" value="JOIN" onClick={login_fn}></input>
      </body>
      :
      <body>
        <label className="rotation_label">ROTATE YOUR PHONE!!!!</label>
      </body>
      }
    </div>
  );
}

export default App;

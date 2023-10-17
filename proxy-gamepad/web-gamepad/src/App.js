import './App.css';
import { useState } from 'react';
import {Button} from './components/Button';
import {PlaceHolder} from './components/PlaceHolder';
import { TouchPad } from './components/TouchPad';

function App() {
  function uuidv4() {
    return "10000000-1000-4000-8000-100000000000".replace(/[018]/g, c =>
      (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    );
  }

  function login_fn() {
    let name = document.querySelector("#name_input").value;
    if (name) {
      setloggedIn(true);
      setnameSelected(name);
    }
  }

  const [loggedIn, setloggedIn] = useState(false);
  const [nameSelected, setnameSelected] = useState("");
  const [playerid, setplayerid] = useState(uuidv4());
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
        <div className='center'>{playerid}</div>
        <div className='center'>{nameSelected}</div>
        <TouchPad className="button" playerid={playerid} nameselected={nameSelected}></TouchPad>
        <PlaceHolder className="cross_place" id="dum" name="↑"/>
        <Button className="button" id="a" playerid={playerid} nameselected={nameSelected} name="!"/>
        <div></div>
      </body>
      :
      <body>
        <label for="name_input">{nameSelected}</label><br></br>
        <input id="name_input"></input>
        <input type="submit" value="JOIN" onClick={login_fn}></input>
      </body>
      }
    </div>
  );
}

export default App;

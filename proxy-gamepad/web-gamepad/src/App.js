import './App.css';
import { useState, useEffect } from 'react';
import {Button} from './components/Button';
import {PlaceHolder} from './components/PlaceHolder';
import { TouchPad } from './components/TouchPad';

function App() {
  function uuidv4() {
    return "10000000-1000-4000-8000-100000000000".replace(/[018]/g, c =>
      (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    );
  }

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
      <div className='center'>{playerid}</div>
      <body>
        <TouchPad className="button" playerid={playerid}></TouchPad>
        <PlaceHolder className="cross_place" id="dum" name="↑"/>
        <Button className="button" id="a" playerid={playerid} name="!"/>
      </body>
    </div>
  );
}

export default App;

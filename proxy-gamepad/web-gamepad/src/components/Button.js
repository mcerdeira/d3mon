import React from 'react';

export const Button = (props) => {

  const onTouchStart = (e) => {
    let app = document.getElementById("App");
    
    try {
      app.requestFullscreen();
    } catch (exceptionVar) {
    }
    e.target.style.backgroundColor = '#FF0000';

    let command = e.target.id;
    let id = props.playerid;

    let url = `http://${process.env.REACT_APP_LOCAL_IP}:8001/${command}/${id}`
    console.log(url)
    try {
      fetch(url);
    } catch (error) {
      return 0;
    }
  }

  const onTouchEnd = (e) => {
    e.target.style.backgroundColor = '#ddd';
  }

    return <div onTouchStart={onTouchStart} onTouchEnd={onTouchEnd} className={props.className} id={props.id}/>
};
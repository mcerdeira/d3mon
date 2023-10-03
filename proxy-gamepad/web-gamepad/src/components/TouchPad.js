import React from 'react';
import { useState, useEffect } from 'react';

export const TouchPad = (props) => {

    function ontouch(el, callback){

        var touchsurface = el,
                dir,
                swipeType,
                startX,
                startY,
                dist,
                distX,
                distY,
                threshold = 150,
                restraint = 100,
                allowedTime = 500,
                elapsedTime,
                startTime,
                mouseisdown = false,
                detecttouch = !!('ontouchstart' in window) || !!('ontouchstart' in document.documentElement) || !!window.ontouchstart || !!window.Touch || !!window.onmsgesturechange || (window.DocumentTouch && window.document instanceof window.DocumentTouch),
                handletouch = callback || function(evt, dir, phase, swipetype, distance){}
    
        touchsurface.addEventListener('touchstart', function(e){
            var touchobj = e.changedTouches[0]
            dir = 'none'
            swipeType = 'none'
            dist = 0
            startX = touchobj.pageX
            startY = touchobj.pageY
            startTime = new Date().getTime() // record time when finger first makes contact with surface
            handletouch(e, 'none', 'start', swipeType, 0) // fire callback function with params dir="none", phase="start", swipetype="none" etc
            e.preventDefault()
        
        }, false)
    
        touchsurface.addEventListener('touchmove', function(e){
            var touchobj = e.changedTouches[0]
            distX = touchobj.pageX - startX // get horizontal dist traveled by finger while in contact with surface
            distY = touchobj.pageY - startY // get vertical dist traveled by finger while in contact with surface
            if (Math.abs(distX) > Math.abs(distY)){ // if distance traveled horizontally is greater than vertically, consider this a horizontal movement
                dir = (distX < 0)? 'left' : 'right'
                handletouch(e, dir, 'move', swipeType, distX) // fire callback function with params dir="left|right", phase="move", swipetype="none" etc
            }
            else{ // else consider this a vertical movement
                dir = (distY < 0)? 'up' : 'down'
                handletouch(e, dir, 'move', swipeType, distY) // fire callback function with params dir="up|down", phase="move", swipetype="none" etc
            }
            e.preventDefault() // prevent scrolling when inside DIV
        }, false)
    
        touchsurface.addEventListener('touchend', function(e){
            var touchobj = e.changedTouches[0]
            elapsedTime = new Date().getTime() - startTime // get time elapsed
            if (elapsedTime <= allowedTime){ // first condition for awipe met
                if (Math.abs(distX) >= threshold && Math.abs(distY) <= restraint){ // 2nd condition for horizontal swipe met
                    swipeType = dir // set swipeType to either "left" or "right"
                }
                else if (Math.abs(distY) >= threshold  && Math.abs(distX) <= restraint){ // 2nd condition for vertical swipe met
                    swipeType = dir // set swipeType to either "top" or "down"
                }
            }
            // fire callback function with params dir="left|right|up|down", phase="end", swipetype=dir etc:
            handletouch(e, dir, 'end', swipeType, (dir =='left' || dir =='right')? distX : distY)
            e.preventDefault()
        }, false)
        
        touchsurface.addEventListener('mousedown', function(e){
            var touchobj = e
            dir = 'none'
            swipeType = 'none'
            dist = 0
            startX = touchobj.pageX
            startY = touchobj.pageY
            startTime = new Date().getTime() // record time when finger first makes contact with surface
            handletouch(e, 'none', 'start', swipeType, 0) // fire callback function with params dir="none", phase="start", swipetype="none" etc
            mouseisdown = true
            e.preventDefault()
        
        }, false)
    
        document.body.addEventListener('mousemove', function(e){
            if (mouseisdown){
                var touchobj = e
                distX = touchobj.pageX - startX // get horizontal dist traveled by finger while in contact with surface
                distY = touchobj.pageY - startY // get vertical dist traveled by finger while in contact with surface
                if (Math.abs(distX) > Math.abs(distY)){ // if distance traveled horizontally is greater than vertically, consider this a horizontal movement
                    dir = (distX < 0)? 'left' : 'right'
                    handletouch(e, dir, 'move', swipeType, distX) // fire callback function with params dir="left|right", phase="move", swipetype="none" etc
                }
                else{ // else consider this a vertical movement
                    dir = (distY < 0)? 'up' : 'down'
                    handletouch(e, dir, 'move', swipeType, distY) // fire callback function with params dir="up|down", phase="move", swipetype="none" etc
                }
                e.preventDefault() // prevent scrolling when inside DIV
            }
        }, false)
    
        document.body.addEventListener('mouseup', function(e){
            if (mouseisdown){
                var touchobj = e
                elapsedTime = new Date().getTime() - startTime // get time elapsed
                if (elapsedTime <= allowedTime){ // first condition for awipe met
                    if (Math.abs(distX) >= threshold && Math.abs(distY) <= restraint){ // 2nd condition for horizontal swipe met
                        swipeType = dir // set swipeType to either "left" or "right"
                    }
                    else if (Math.abs(distY) >= threshold  && Math.abs(distX) <= restraint){ // 2nd condition for vertical swipe met
                        swipeType = dir // set swipeType to either "top" or "down"
                    }
                }
                // fire callback function with params dir="left|right|up|down", phase="end", swipetype=dir etc:
                handletouch(e, dir, 'end', swipeType, (dir =='left' || dir =='right')? distX : distY)
                mouseisdown = false
                e.preventDefault()
            }
        }, false)
    }

    useEffect(()=>{

        var el = document.getElementById('touchsurface')
        ontouch(el, function(e, dir, phase, swipetype, distance){
            var touchreport = ''
            touchreport += '<b>Dir:</b> ' + dir + '<br />'
            touchreport += '<b>Phase:</b> ' + phase + '<br />'
            el.innerHTML = touchreport

            let app = document.getElementById("App");
            //app.requestFullscreen();
            e.target.style.backgroundColor = '#aaa';
            let command = dir;
            if (phase == "end"){
                command = "end"
            }

            let id = props.playerid;
            let url = `http://${process.env.REACT_APP_LOCAL_IP}:8001/${command}/${id}`
            console.log(url)
            try {
              fetch(url);
            } catch (error) {
              return 0;
            }



        })
        }, [])

    return <div id="touchsurface" className={props.className}></div>
}
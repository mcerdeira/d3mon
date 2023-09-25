import React from 'react';

export const PlaceHolder = (props) => {
  return <div className={props.className} id={props.id}>{props.name}</div>
};
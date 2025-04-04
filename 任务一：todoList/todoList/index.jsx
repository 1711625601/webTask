import "./css/index.css";
import Header from "./header";
import Footer from "./footer";
import Body from "./body";
import { useState } from "react";

function TodoList() {
  const [list, setList] = useState([
    {
      id: 1,
      title: "吃饭",
      isDone: false,
    },
    {
      id: 2,
      title: "睡觉",
      isDone: false,
    },
  ]);
  function generateUniqueId() {
    return "id-" + Date.now() + "-" + Math.floor(Math.random() * 1000);
  }
  const handleAdd = (value) => {
    setList([...list, { id: generateUniqueId(), title: value, isDone: false }]);
  };
  const handleDelete = (id) => {
    setList(list.filter((item) => item.id !== id));
  };
  const handleCheck = (id) => {
    setList(
      list.map((item) =>
        item.id === id ? { ...item, isDone: !item.isDone } : item
      )
    );
  };

  const handleAll = () => {
    let isDone = list.every((item) => item.isDone);
    setList(list.map((item) => ({ ...item, isDone: !isDone })));
  };
  const handleDel = () => {
    setList(list.filter((item) => !item.isDone));
  };
  return (
    <>
      <div className="todo-list">
        <Header handleAdd={handleAdd}></Header>
        <Body
          list={list}
          handleDelete={handleDelete}
          handleCheck={handleCheck}
        ></Body>
        <Footer
          list={list}
          handleAll={handleAll}
          handleDel={handleDel}
        ></Footer>
      </div>
    </>
  );
}

export default TodoList;

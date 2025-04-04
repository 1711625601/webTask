import { useRef } from "react";
function Header({ handleAdd }) {
  const inputRef = useRef();
  function addItem(e) {
    handleAdd(e);
    inputRef.current.value = "";
  }
  return (
    <>
      <div className="todo-list-header">
        <input
          ref={inputRef}
          type="text"
          placeholder="请输入待办事项"
          onKeyDown={(e) => {
            if (e.key === "Enter") {
              addItem(inputRef.current.value);
            }
          }}
        />
        <button onClick={() => addItem(inputRef.current.value)}>添加</button>
      </div>
    </>
  );
}

export default Header;

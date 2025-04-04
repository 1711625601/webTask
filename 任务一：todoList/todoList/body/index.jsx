function Body({ list, handleDelete, handleCheck }) {
  return (
    <>
      <div className="todo-list-body">
        {list.map((item) => {
          return (
            <div className="todo-list-item" key={item.id}>
              <input
                type="checkbox"
                checked={item.isDone}
                onChange={() => handleCheck(item.id)}
              />
              {item.title}
              <button onClick={() => handleDelete(item.id)}>删除</button>
            </div>
          );
        })}
      </div>
    </>
  );
}

export default Body;

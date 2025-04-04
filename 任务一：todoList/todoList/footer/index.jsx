function Footer({ list, handleAll, handleDel }) {
  const noHandle = list.reduce((accumulator, currentValue) => {
    if (currentValue.isDone) return accumulator + 1;
    return accumulator;
  }, 0);
  return (
    <>
      <div className="todo-list-footer">
        <div>
          <input
            type="checkbox"
            checked={noHandle === list.length}
            onChange={() => handleAll()}
          />
          <span>
            {noHandle}/{list.length}
          </span>
        </div>
        <button onClick={() => handleDel()}>删除已完成</button>
      </div>
    </>
  );
}

export default Footer;

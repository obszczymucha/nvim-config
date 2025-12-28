function hello() {
  console.log("Hello world");
  return true;
}

function test() {
  const result = hello();
  return result;
}

module.exports = { hello, test };

console.log(`Spinning up...`);

const token = "foobar2";

function result(handler: string) {
  console.log(`Execute ${handler}`);
  return {
    statusCode: 200,
    headers: {
      "x-custom-header" : "my custom header value"
    },
    body: JSON.stringify({
      handler,
      token
    })
  };
}

export const handler1 = async (req: any) => {
  return result("handler 1");
}

export const handler2 = async (req: any) => {
  return result("handler 2");
}
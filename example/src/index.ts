console.log(`Spinning up...`);

function result(handler: string) {
  console.log(`Execute ${handler}`);
  return {
    statusCode: 200,
    headers: {
      "x-custom-header" : "my custom header value"
    },
    body: JSON.stringify({
      handler
    })
  };
}

export const handler = async (req: any) => {
  return result("handler ok!");
}
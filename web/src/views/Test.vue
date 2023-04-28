<template>
  <div>测试页面</div>
</template>

<script setup>
// new Promise((resolve, reject) => {
//   setTimeout(() => {
//     resolve("成功");
//   }, 3000);
// }).then((value) => {
//   console.log(value);
// });

console.log("1");
const test = async () => {
  try {
    const res = await new Promise((resolve, reject) => {
      setTimeout(() => {
        reject("失败");
      }, 3000);
    });
  } catch (error) {
    console.log(error);
  }

  //console.log(res);
};

test();
</script>

<style scoped></style>

我需要用简单的 quasar 框架构建一个体重记录 app。代码中无论注释还是输出都使用英文。

**代码需求：**

1. 我已经构建了 quasar 的 vuejs3 工程，使用的 script setup 类型的代码。
2. 只需要输出代码，不需要解释，每一个界面一个独立的文件。
3. 尽量避免 large function，可以尽量切分为小功能的 function，对于无重用价值的只有一两行的小功能 function 不用特意拆分出来。
4. 界面元素和 css 设计都尽量使用 quasar 中的标准实现方式。
5. 这里给出一个模板页面代码：

```vue
<template>
  <q-page class="row items-center justify-evenly">
    <example-component
      title="Example component"
      active
      :todos="todos"
      :meta="meta"
    ></example-component>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { Todo, Meta } from 'components/models';
import ExampleComponent from 'components/ExampleComponent.vue';

defineOptions({
  name: 'IndexPage',
});

const todos = ref<Todo[]>([]);

const meta = ref<Meta>({
  totalCount: 1200,
});
</script>
```

**界面需求：**

- Initialization UI
  - inputs:
    - sex selection(male/female)
    - height
    - weight
  - submit button
- Claim name
  - one input box, named "name"
  - after the text box blur, trigger a name availability check, if pass, a green check mark shows along with a simple text tell user it's available, otherwise, a red cross and a error message shows
  - if the name is available, user allow to "Claim" this name
- Daily input panel
  - one input box, named "weight"
  - one submit button
  - at the bottom, there is standard mobile menu at the bottom, which allow user to quickly navigate through 4 panels.
- Reward panel
  - show reward points for user, which is two line card box, on the left, first line is name, second line is points number, on the right is the rank number.
  - task list display
    - each item of task list is also a two line card box, on the left, first line is task name, second line is summary, on the right is the "prove" button
    - this list contains max 10 tasks, when user scroll up and down, only this task list will scroll.
  - backend logic(can be ignored in UI code):task prove and participate
- graph curve panel
  - a simple line diagram to show weight trend, which x axis is the date while y axis is the weight.
- leaderborad panel
  - leaderboard is list could be scroll up and down
    each item show points for user, which is two line card box, on the left, first line is name, second line is points number, on the right is the rank number.

<template>
  <q-page class="flex justify-center q-pt-lg">
    <div class="wrapper-settings">
      <q-file
        color="primary"
        class="q-mb-lg"
        :loading="fileLoading"
        @update:model-value="uploadFile"
        v-model="file"
        label-color="secondary"
        label="Загрузить файл"
      >
        <template v-slot:append>
          <q-icon name="add_circle_outline" size="30px" color="primary" />
        </template>
      </q-file>
      <div>
        <div class="table shadow-3">
          <div class="head shadow-2">Загруженные файлы</div>
          <div v-for="(file, i) in files" :key="file.id" class="t-row">
            <div>
              {{ file.filename }}
            </div>
            <q-space></q-space>
            <div class="row">
              <div class="row items-center justify-center" style="width: 120px">
                {{ (file.size / 1024).toFixed(1) + " кб" }}
              </div>
              <div class="row items-center q-mx-sm">{{ file.created_at }}</div>
              <div
                class="row items-center q-mx-lg justify-center"
                style="min-width: 80px"
              >
                {{ file.file_type }}
              </div>
              <div>
                <q-btn
                  v-show="!file.isDownloading"
                  size="15px"
                  @click="download(file, i)"
                  flat
                  round
                  color="primary"
                  icon="description"
                />
                <q-spinner
                  style="margin: 0 12px 0 12px"
                  v-show="file.isDownloading"
                  size="20px"
                  :thickness="6"
                  color="primary"
                />
                <q-btn
                  size="15px"
                  style="margin-right: -7px"
                  @click="dropFile(file.id)"
                  flat
                  round
                  color="negative"
                  icon="delete"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { ref } from "vue";
import { Notify } from "quasar";
import { onMounted } from "vue";
import FileService from "src/services/FileService";

const fileLoading = ref(false);
const file = ref();
const files = ref([]);

async function download({ url, filename }, i) {
  files.value[i].isDownloading = true;
  await fetch(url)
    .then((response) => response.blob())
    .then((blob) => {
      const link = document.createElement("a");
      link.href = URL.createObjectURL(blob);
      link.download = filename;
      link.click();
    })
    .catch(console.error);
  files.value[i].isDownloading = false;
}

async function dropFile(id) {
  await FileService.dropFile(id);
  files.value = (await FileService.getFiless()).data.map((file) => {
    return { ...file, isDownloading: false };
  });
}

onMounted(async () => {
  files.value = (await FileService.getFiless()).data.map((file) => {
    return { ...file, isDownloading: false };
  });
  console.log(files.value);
});

function checkResp(resp, message = "Данные добавлены") {
  if (resp.error) {
    Notify.create({
      color: "negative",
      message: "Произошла ошибка",
    });
  } else {
    Notify.create({
      color: "positive",
      message: message,
    });
  }
}
async function uploadFile(v) {
  fileLoading.value = true;
  const resp = await FileService.uploadFile(v);
  fileLoading.value = false;
  checkResp(resp);
  files.value = (await FileService.getFiless()).data;
}
</script>
<style scoped lang="scss">
.wrapper-settings {
  min-width: 70%;
  width: 800px;
}

.table {
  color: black;
  background-color: white;
  border-radius: 4px;

  .head {
    padding: 8px;
    font-weight: 400;
    font-size: 22px;
    border-bottom: 1px solid black;
  }

  .t-row {
    font-size: 16px;
    padding: 8px;
    display: flex;
    border-bottom: 1px solid black;
    align-items: center;
  }
}
</style>

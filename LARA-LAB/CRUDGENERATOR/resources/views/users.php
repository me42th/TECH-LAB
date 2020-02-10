<script src="http://unpkg.com/vue"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<div id="app">
<ul>
  <li v-for="pessoa in info.data.data">
    {{ pessoa.name }}
  </li>
</ul>
</div>
<script>
new Vue({
  el: '#app',
  data () {
    return {
      info: null
    }
  },
  mounted () {
    setTimeout(
      () =>  axios
              .get('http://localhost:8000/api/users')
              .then(response => (this.info = response))
      ,4000
    )
  }
})
</script>
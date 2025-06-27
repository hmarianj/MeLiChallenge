# MeLiChallenge

Challenge Técnico Mobile para MercadoLibre

## Requerimientos

- Crear una app iOS utilizando la [SpaceflightNews API](https://api.spaceflightnewsapi.net/v4/docs/)
- Mostrar 2 pantallas: Un Listado de noticias con Search y un Detalle del Artículo

## Solución

- SwiftUI app, utilizando el patrón MVVM con Dependency Injection
- La UI reacciona a los cambios de estado en los ViewModels
- Test unitarios de los cambios de estado en los ViewModels, mockeando las dependencias (Services)
- Capa de Networking sencilla para realizar HTTP Requests usando async/await
  - Logs a consola para cada request/response
  - Manejo de errores
- Soporte para Light/Dark mode
- Soporte para accessibilidad (VoiceOver, DynamicType)
- Soporte Portrait/Landscape
- La app puede correr en dispositivos iPhone/iPad

### HomeScreen

- Listado de `Artículos`, utilizando la [API de articles](https://api.spaceflightnewsapi.net/v4/articles/)
- La respuesta de la API es paginada, la lista tiene scroll infinito, la lógica de manejo de paginado está en el ViewModel
- Navegación al detalle al hacer tap en un artículo
- Funcionalidad de búsqueda, utilizando un debouncer para solo buscar cuando pasó 1 segundo desde el último cambio en la query de Search
- Para la búsqueda, se utiliza la misma API, pero con el query parameter de `"search"`
- Adicionalmente, se muestra un listado de `Reportes`, en un scroll horizontal, utilizando la [API de Reports](https://api.spaceflightnewsapi.net/v4/reports/)
- Manejo de estados de `loading` y `error` con posibilidad de Reintentar

### NewsDetailsScreen

- Pantalla de detalle de un `Artículo`
- Dado que la [API de articles](https://api.spaceflightnewsapi.net/v4/articles/) ya nos trae toda la información de los artículos, no fue necesario agregar una segunda llamada a la API de artículos para un `ID` especifico.

### Dependencias

- [Nuke](https://github.com/kean/Nuke.git): Para una mejor experiencia de Usuario en cuánto a la carga y caché de las imágenes.

## Video Demo

### Home + Search + Details

| Light Mode | Dark Mode |
| - | - |
|![demo-light](/images/LMAppVideo.gif)|![demo-dark](/images/DMAppVideo.gif)|

### Landscape Support

| Light Mode | Dark Mode |
| - | - |
|![demo-landscape-light](/images/LMLSVideo.gif)|![demo-landscape-dark](/images/DMLSVideo.gif)|

## Image Demo

### HomeScreen

| Light Mode | Dark Mode |
| - | - |
|![home-light](/images/LMHome.png)|![home-dark](/images/DMHome.png)|

### HomeScreen + Search

| Light Mode | Dark Mode |
| - | - |
|![home-search-light](/images/LMSearch.png)|![home-search-dark](/images/DMSearch.png)|

### NewsDetailsScreen

| Light Mode | Dark Mode |
| - | - |
|![details-light](/images/LMDetails.png)|![details-dark](/images/DMDetails.png)|

### Loading State + Error State

| Load State | Error State |
| - | - |
|![loading-light](/images/LoadingView.png)|![error-light](/images/LMErrorView.png)|

### iPad Support

| Light Mode | Dark Mode |
| - | - |
|![ipad-home-light](/images/LMHomeIpad.png)|![ipad-home-dark](/images/DMHomeIpad.png)|
|![ipad-details-light](/images/LMDetailsIpad.png)|![ipad-details-dark](/images/DMDetailsIpad.png)|

### iPad Landscape

| Light Mode | Dark Mode |
| - | - |
|![ipad-landscape-home-light](/images/LMLSIpad.png)|![ipad-landscape-home-dark](/images/DMLSIpad.png)|

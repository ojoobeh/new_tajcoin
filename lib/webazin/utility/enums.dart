import 'package:get/get_rx/src/rx_types/rx_types.dart';

enum EHttpMethod { get, post, put, patch, delete }

enum PageState { initial, loading, loaded, error, empty, paging, done }

extension PageStateExtension on PageState {
  bool isInitial() => this == PageState.initial;

  bool isLoading() => this == PageState.loading;

  bool isLoaded() => this == PageState.loaded;

  bool isError() => this == PageState.error;

  bool isPaging() => this == PageState.paging;
}

extension RxPageStateExtension on Rx<PageState> {
  bool isLoading() => value == PageState.loading;

  bool isLoaded() => value == PageState.loaded;

  bool isDone() => value == PageState.done;

  bool isInitial() => value == PageState.initial;

  bool isError() => value == PageState.error;

  bool isPaging() => value == PageState.paging;

  PageState initial() => this(PageState.initial);

  PageState done() => this(PageState.done);

  PageState loading() => this(PageState.loading);

  PageState loaded() => this(PageState.loaded);

  PageState error() => this(PageState.error);

  PageState paging() => this(PageState.paging);
}

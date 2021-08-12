
```
p. = problem
pr. = proposal
o. = observation
ex. = expectation
e. = explanation
```

- [x] RemoteDataModel -> RemoteValue
- [x] RemoteDataBlop -> RemoteValueBlop
- [x] PersistentBlop -> PersistentValueBlop

- [x] remote_data -> remote_value
- [x] remote_data_flutter -> flutter_remote_value
- [-] remote_data_stream -> remote_value_stream
- add sliver_stream_builder -> sliver_stream_builder_delegate
    - how to integrate with remote data stream
        - p.1 - rds require `dio` instance 
        - p.2 - ssb require unnecessary dependency
        - pr.1 - pass to ssb data stream and optionaly loading stream,this remove deps from rds and dio
        - pr.2 - kiss [my ass] just accept stream
        - p.3 - state widgets has text need localization and styling

- [-] extract persistent_blop to package
- [-] extract persistent_store to package
- [-] extract blop to other repo???

- rename massa_utils -> massa_utils
- [-] extract massa_utils to other repo???

- rename repository bloc_extension -> massa.flutter.packages
- fast_i18n fork with adaptation to package localization
    - pr.0 - interactive cli to choose package for localization
- publish to pub.dev

- add test to blop_generator
    - p.0 - need info about builder testing

# Documentation

- [ ] remote_value
    - [x] remote_value
    - [ ] persistent_value
    - [ ] persistent_store

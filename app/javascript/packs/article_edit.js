import React from 'react';
import ReactDOM from 'react-dom';
import {Upload, Button, Icon} from 'antd';

class AssetManager extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            fileList: props.fileList
        };
    }

    handleChange(info) {
        let fileList = info.fileList;

        fileList = fileList.map((file) => {
            if (file.response) {
                file.url = file.response.url;
            }
            return file;
        });

        this.setState({fileList});
    }

    handleRemove(file) {
        let promise = $.ajax({
            url: Routes.asset_article(gon.article_id, {file_name: file.name}),
            method: 'delete'
        });
        promise.done(() => {
            return true;
        });
        return promise;
    }

    render() {
        const props = {
            action: Routes.assets_article(gon.article_id),
            onChange: this.handleChange.bind(this),
            onRemove: this.handleRemove.bind(this),
            multiple: true,
            data: {},
        };
        props.data[Rails.csrfParam()] = Rails.csrfToken();
        return (
            <Upload {...props} fileList={this.state.fileList}>
                <Button>
                    <Icon type="upload"/> Click to Upload
                </Button>
            </Upload>
        );
    }
}

window.onload = function () {
    let mountedNode = document.getElementById('assets-manager')
    if (mountedNode) {
        $.get(Routes.assets_article(gon.article_id), (fileList) => {
            ReactDOM.render(<AssetManager fileList={fileList}/>, mountedNode);
        });
    }
};

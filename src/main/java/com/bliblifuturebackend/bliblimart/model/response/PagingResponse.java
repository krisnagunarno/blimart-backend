package com.bliblifuturebackend.bliblimart.model.response;

import com.blibli.oss.common.paging.Paging;
import com.bliblifuturebackend.bliblimart.model.request.PagingRequest;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class PagingResponse<T> {

    private List<T> data;

    private Paging paging;

    public PagingResponse (){
    }

    public PagingResponse (List<T> data, Paging paging){
        this.data = data;
        this.paging = paging;
    }

    public PagingResponse<T> getPagingResponse(PagingRequest request, int total){
        int totalPage = (int) Math.ceil(total/(float)request.getSize());
        Paging paging = Paging.builder()
                .page(request.getPage() + 1)
                .itemPerPage(request.getSize())
                .totalItem(total)
                .totalPage(totalPage)
                .build();
        this.setPaging(paging);
        return this;
    }
}
